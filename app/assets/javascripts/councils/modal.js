$(document).on('turbolinks:load', function() {
  // on profil act as a link
  if(window.location.pathname == '/profile') {
    $("body").on( "click", ".single-council-card, .single-council-list", function() {
      var interested = $(this).find('.council-content .interested').attr('href');
      window.location.href = interested
    });
  } else {
  // when a post is clicked, show its full content in a modal window
    $("body").on( "click", ".single-council-card, .single-council-list", function() {
      var posted_by = $(this).find('.council-content .posted-by').html();
      var post_heading = $(this).find('.council-content h3').html();
      var post_cat = $(this).find('.council-content h2').html();
      var post_content = $(this).find('.council-content p').html();
      var interested = $(this).find('.council-content .interested').attr('href');
      var interested_text = $(this).find('.council-content .interested').html();
      $('.modal-header .posted-by').text(posted_by);
      $('.loaded-data h3').text(post_heading);
      $('.loaded-data .council-desc p').text(post_content);
      $('.loaded-data .council-cat p').text(post_cat);
      $('.loaded-data .interested a').attr('href', interested);
      $('.loaded-data .interested a').text(interested_text);
      $('.myModal').modal('show');
    });
  };
});