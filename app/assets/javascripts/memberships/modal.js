$(document).on('turbolinks:load', function() {
  // when a post is clicked, show its full content in a modal window
  
    $("body").on( "click", ".single-member-card, .single-member-list", function() {
      var posted_by = $(this).find('.member-content .posted-by').html();
      var post_heading = $(this).find('.memebr-content h3').html();
      var post_content = $(this).find('.member-content p').html();
      var interested = $(this).find('.member-content .interested').attr('href');
      var interested_text = $(this).find('.member-content .interested').html();
      $('.modal-header .posted-by').text(posted_by);
      $('.loaded-data h3').text(post_heading);
      $('.loaded-data p').text(post_content);
      $('.loaded-data .interested a').attr('href', interested);
      $('.loaded-data .interested a').text(interested_text);
      $('.myModal').modal('show');
    });
});