$(document).on('turbolinks:load', function() {
  if(window.location.pathname == '/user_posts' || window.location.pathname == '/council_posts') {
    $("body").on( "click", ".single-post-card, .single-post-list", function() {
      var interested = $(this).find('.post-content .interested').attr('href');
      window.location.href = interested
    });
  } else {
    // when a post is clicked, show its full content in a modal window
    $("body").on( "click", ".single-post-card, .single-post-list", function() {
      var posted_by = $(this).find('.post-content .posted-by').html();
      var post_heading = $(this).find('.post-content h3').html();
      var post_content = $(this).find('.post-content p').html();
      var interested = $(this).find('.post-content .interested').attr('href');
      var interested_text = $(this).find('.post-content .interested').html();
      $('.modal-header .posted-by').text(posted_by);
      $('.loaded-data h3').text(post_heading);
      $('.loaded-data p').text(post_content);
      $('.loaded-data .interested a').attr('href', interested);
      $('.loaded-data .interested a').text(interested_text);
      $('.myModal').modal('show');
    });
  };
});