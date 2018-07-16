$(document).on('turbolinks:load', function() {
  // when a post is clicked, show its full content in a modal window
  $("body").on( "click", ".pos-votes-card, .pos-votes-list", function() {
    var posted_by = $(this).find('.pos-votes-content .posted-by').html();
    var post_heading = $(this).find('.pos-votes-content h3').html();
    var post_content = $(this).find('.pos-votes-content p').html();
    var interested = $(this).find('.pos-votes-content .interested').attr('href');
    $('.modal-header .posted-by').text(posted_by);
    $('.loaded-data h3').text(post_heading);
    $('.loaded-data p').text(post_content);
    $('.loaded-data .interested a').attr('href', interested);
    $('.myModal').modal('show');
  });
});