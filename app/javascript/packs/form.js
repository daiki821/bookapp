import axios from 'modules/axios'

document.addEventListener( 'DOMContentLoaded', () => {
  $('.clear-icon-box').first().removeClass('hidden')

  $('.clear-icon-box').on('click', () => {
    $('.message-ul').addClass('hidden')
  })
})