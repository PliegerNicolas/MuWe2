import Swiper from 'swiper';

var jamSwiper = new Swiper('.jam-swiper-container', {
  direction: 'vertical',
  watchOverflow: true,
  slidesPerView: 'auto',
  navigation: {
    nextEl: '.jam-swiper-button-next',
    prevEl: '.jam-swiper-button-prev',
  },
});

export default jamSwiper;
