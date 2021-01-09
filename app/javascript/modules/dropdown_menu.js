const openDropdownMenu = (element) => {
  if($(element).find('.dropdown-box').hasClass('hidden')){
    $(element).find('.dropdown-box').removeClass('hidden')
  } else {
    $(element).find('.dropdown-box').addClass('hidden')
  }
    
 
}


export{
  openDropdownMenu
}