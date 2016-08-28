$(document).ready(function(){
  // get the value of the bottom of the #main element by adding the offset of that element plus its height, set it as a variable
  var mainbottom = $('.banner-content').offset().top + $('.banner-content').height();

  // on scroll
  $(window).on('scroll',function(){

      // we round here to reduce a little workload
      stop = Math.round($(window).scrollTop());
      if (stop > mainbottom) {
          $('.nav').addClass('past-scroll');
      } else {
          $('.nav').removeClass('past-scroll');
     }

  });
});
