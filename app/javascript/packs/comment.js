import axios from 'modules/axios'

import {
  openDropdownMenu,
  addComment,
  commentForm
} from 'modules/handle_comment'

document.addEventListener('DOMContentLoaded', () => {
  const recommendId = $('.recommend-outline').data().recommendId
  axios.get(`/recommends/${recommendId}/comments`)
    .then( (response) => {
      const comment = response.data

      $(comment).each( (i, element) => {
        addComment(element)
      })

      $('.comment-card').each((i,element) => {

        openDropdownMenu(element)

        $(element).find('.d-menu').on('click', () => {
          const commentId = $(element).data().commentId 
          axios.delete(`/recommends/${recommendId}/comments/${commentId}`)
            .then((res) => {
              const status = res.data.status
              if(status == 'ok'){
                $(element).remove()
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
          const element = response.data
          addComment(element)
          $('.comment-text-area').val('')

          $('.comment-card').each((i,element) => {

            openDropdownMenu(element)
    
            $(element).find('.d-menu').on('click', () => {
              const commentId = $(element).data().commentId 
              axios.delete(`/recommends/${recommendId}/comments/${commentId}`)
                .then((res) => {
                  const status = res.data.status
                  if(status == 'ok'){
                    $(element).remove()
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