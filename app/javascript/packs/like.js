import axios from 'modules/axios'
import{
  clickHeart,
  clickActiveHeart
} from 'modules/handle_heart'

document.addEventListener( 'DOMContentLoaded', () => {
  $('.recommend-outline').each( (index, element) => {
    const data = $(element).data()
    const recommendId = data.recommendId
    axios.get(`/recommends/${recommendId}/like`)
      .then( (response) => {
        const hasLiked = response.data.hasLiked
        if(hasLiked){
          $(element).find('.heart').addClass('hidden')
        }else{
          $(element).find('.active-heart').addClass('hidden')
        }
      })

    clickHeart(element, recommendId)

    clickActiveHeart(element, recommendId)

    
  })
})