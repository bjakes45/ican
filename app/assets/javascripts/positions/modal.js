$(document).on('turbolinks:load', function() {
  // when a post is clicked, show its full content in a modal window
  
    $("body").on( "click", ".single-position-card, .single-position-list", function() {
      var posted_by = $(this).find('.position-content .posted-by').html();
      var post_heading = $(this).find('.position-content h3').html();
      var post_content = $(this).find('.position-content p').html();
      var interested = $(this).find('.position-content .interested').attr('href');
      $('.modal-header .posted-by').text(posted_by);
      $('.loaded-data h3').text(post_heading);
      $('.loaded-data p').text(post_content);
      $('.loaded-data .interested a').attr('href', interested);
      $('.myModal').modal('show');
    });
});