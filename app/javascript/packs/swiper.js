import Swiper from 'swiper';

var jamSwiper = new Swiper('.swiper-container', {
  direction: 'vertical',
  watchOverflow: true,
  slidesPerView: 'auto',
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
});

export default jamSwiper;
