import axios from 'modules/axios'

const clickHeart = (element, recommendId) => {
  $(element).find('.heart').on('click', () => {
    axios.post(`/recommends/${recommendId}/like`)
      .then( (response) => {
        if (response.data.status == 'ok'){
          $(element).find('.heart').addClass('hidden')
          $(element).find('.active-heart').removeClass('hidden')
        }
      })
  
      .catch( (e) => {
        window.alert('error')
        console.log(e)
      })
  })
}

const clickActiveHeart = (element, recommendId) => {
  $(element).find('.active-heart').on('click', () => {
    axios.delete(`/recommends/${recommendId}/like`)
      .then( (response) => {
        if(response.data.status == 'ok'){
          $(element).find('.active-heart').addClass('hidden')
          $(element).find('.heart').removeClass('hidden')
        }
      })
      .catch( (e) => {
        window.alert('error')
        console.log(e)
      })
  })

}



export {
  clickHeart,
  clickActiveHeart
}