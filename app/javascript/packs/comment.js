import axios from 'modules/axios'
import{ openDropdownMenu} from 'modules/dropdown_menu'
import {
  addComment,
  commentForm
} from 'modules/handle_comment'

document.addEventListener('DOMContentLoaded', () => {
  const recommendId = $('.recommend-outline').data().recommendId
  axios.get(`/recommends/${recommendId}/comments`)
    .then( (response) => {
      const comments = response.data.data
      const currentUserId = response.data.meta
      comments.forEach( (comment) => {
        addComment(comment)
      })
      

      $('.comment-card').each((i,element) => {
        const userId = $(element).find('.comment-user-icon-box').data().userId

        if(userId == currentUserId){
          $(element).find('.comment-edit-box').removeClass('hidden')
        }

        $(element).find('.comment-edit-box').on('click', () => {
          openDropdownMenu(element)
        })
        
        $(element).find('.d-menu').on('click', () => {
          const commentId = $(element).data().commentId 
          axios.delete(`/recommends/${recommendId}/comments/${commentId}`)
            .then((res) => {
              const status = res.data.status
              if(status == 'ok'){
                $(element).remove()
                $('.comment-count').text(res.data.commentCount)
              }
            })

            .catch((e) => {
              window.alert(e)
            })
        })

      })
    })

    .catch( (e) => {
      window.alert(e)
    })



  commentForm()


  $('.add-comment-btn').on('click', () => {
    const content = $('.comment-text-area').val()
    if(content.match(/\S/g)){
      axios.post(`/recommends/${recommendId}/comments`,{
        comment: {content: content}
      })
        .then( (response) => {
          const currentUserId = response.data.meta.id
          const comment = response.data.data

          addComment(comment)
          $('.comment-count').text(response.data.meta.count)


          $('.comment-card').each((i,element) => {
            const userId = $(element).find('.comment-user-icon-box').data().userId

            if(userId == currentUserId){
              $(element).find('.comment-edit-box').removeClass('hidden')
            }

            $(element).find('.comment-edit-box').off('click')
            $(element).find('.comment-edit-box').on('click', () => {
              openDropdownMenu(element)
            })
            
            $(element).find('.d-menu').on('click', () => {
              const commentId = $(element).data().commentId 
              axios.delete(`/recommends/${recommendId}/comments/${commentId}`)
                .then((res) => {
                  const status = res.data.status
                  if(status == 'ok'){
                    $(element).remove()
                    $('.comment-count').text(res.data.commentCount)
                  }
                })
    
                .catch((e) => {
                  window.alert(e)
                })
            })
    
          })


        })

        .catch( (e) => {
          console.log(e)
          window.alert(e)
        })
    } else {
      window.alert('コメントを入力してください')
    }
  })


})