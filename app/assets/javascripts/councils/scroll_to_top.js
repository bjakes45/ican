$(window).on('scroll',function(){
    if ($(this).scrollTop() > 125) {
        $(".scrollToTop").fadeIn(1000)
    } else {
        $(".scrollToTop").fadeOut(1000);
    }
});

$(document).on('turbolinks:load', function() {
    //Click event to scroll to top
    $(".scrollToTop").click(function(event){
        event.preventDefault();
        $('html, body').animate({scrollTop : 0},500);
        $(".scrollToTop").fadeOut(1000);
    });
});