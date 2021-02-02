import axios from 'modules/axios'


const commentForm = () => {
  $('.comment-btn').on('click', () => {
    $('.comment-btn').addClass('hidden')
    $('.comment-form').removeClass('hidden')
  })
}




const addComment = (comment) => {
  $('.comment-box').append(`<div class="comment-card" data-comment-id="${comment.id}"><div class="comment-user-box"><div class="comment-user-icon-box"><img src="${comment.attributes.avatar}" class="comment-user-icon"></div><div class="comment-username"><p>${comment.attributes.username}</p></div><div class="comment-edit-box"><i class="fas fa-ellipsis-h edit-icon"></i><div class="dropdown-box hidden"><div class="d-menu-box"><div class="d-menu ">削除</div></div></div></div></div><div class="comment-content-box"><p>${comment.attributes.content}</p></div></div></div>`)
  $('.comment-text-area').val('')
}




export {
  addComment,
  commentForm
}