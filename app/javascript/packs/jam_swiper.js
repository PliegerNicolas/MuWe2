import Swiper from 'swiper';

console.log("a");

let jamSwiper = new Swiper('.swiper-container', {
  direction: 'vertical',
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
  },
});

export default jamSwiper;
