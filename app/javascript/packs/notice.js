function animateNotice(notice) {
  const nav = document.getElementsByTagName("nav")[0];
  bottomNav = nav.getBoundingClientRect().bottom;
  notice.animate([
    { transform: 'translateY(0)' },
    { transform: `translateY(${bottomNav}px)` }
  ],
    {
      duration: 700,
      delay: 20,
      easing: 'ease-in-out',
      fill: 'forwards'
     }
  );
}

function noticeDropdown() {
  const notice = document.getElementById("notice");
  if(notice) {
    animateNotice(notice);
  }
}

noticeDropdown();
