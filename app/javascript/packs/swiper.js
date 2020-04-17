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

var localPostSwiper = new Swiper('.local-post-swiper-container', {
  watchOverflow: true,
  slidesPerView: 'auto',
  navigation: {
    nextEl: '.local-post-swiper-button-next',
    prevEl: '.local-post-swiper-button-prev',
  },
});

export { jamSwiper, localPostSwiper };
