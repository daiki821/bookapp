import axios from 'modules/axios'


const commentForm = () => {
  $('.comment-btn').on('click', () => {
    $('.comment-btn').addClass('hidden')
    $('.comment-form').removeClass('hidden')
  })
}

const openDropdownMenu = (element) => {
  $(element).find('.comment-edit-box').on('click', () => {
    if($(element).find('.dropdown-box').hasClass('hidden')){
      $(element).find('.dropdown-box').removeClass('hidden')
    } else {
      $(element).find('.dropdown-box').addClass('hidden')
    }
    
  })
}


const addComment = (element) => {
  $('.comment-box').append(`<div class="comment-card" data-comment-id="${element.id}"><div class="comment-user-box"><div class="comment-user-icon-box"><img src="${element.avatar_url}" class="comment-user-icon"></div><div class="comment-username"><p>${element.username}</p></div><div class="comment-edit-box"><i class="fas fa-ellipsis-h edit-icon"></i><div class="dropdown-box hidden"><div class="d-menu ">削除</div></div></div></div><div class="comment-content-box"><p>${element.content}</p></div></div></div>`)
}









export {
  openDropdownMenu,
  addComment,
  commentForm
}