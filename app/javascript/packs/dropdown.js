import axios from 'modules/axios'
import {openDropdownMenu} from 'modules/dropdown_menu'


document.addEventListener( 'DOMContentLoaded', () => {
  $('.recommend-outline').each( (i,element) => {
    $(element).find('.recommend-edit-box').on( 'click', () => {
      openDropdownMenu(element)
    })
  })


  $('.book-list').each((i, element) => {
    $(element).find('.edit-icon-box').on('click', () => {
      openDropdownMenu(element)
    })
  })

})

