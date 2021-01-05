import axios from 'modules/axios'


document.addEventListener('DOMContentLoaded', () => {
  const recommendId = $('.recommend-outline').data().recommendId
  axios.get(`/recommends/${recommendId}/comments`)
    .then( (response) => {
      const comment = response.data
      $(comment).each( (i, element) => {
        console.log(element)
        $('.comment-box').append(`<div class="comment-card"><div class="comment-user-box"><div class="comment-user-icon-box"><img src="${element.avatar_url}" class="comment-user-icon"></div><div class="comment-username"><p>${element.username}</p></div></div>  <div class="comment-content-box"><p>${element.content}</p></div></div></div>`)
      })
    })

    .catch( (e) => {
      window.alert(e)
    })



  $('.comment-btn').on('click', () => {
    $('.comment-btn').addClass('hidden')
    $('.comment-form').removeClass('hidden')
  })


  


})