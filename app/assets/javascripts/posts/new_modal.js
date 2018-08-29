$(document).on('turbolinks:load', function() {
	$("body").on( "click", "#new_post", function(event) {
      event.preventDefault();
      $('.newModal').modal('show');
    });
});

$(document).on('turbolinks:load', function() {
    $('#modal-submit').click(function () {
        $(this.form).submit();
        $('#newModal').modal('hide');
    });
});

$(document).on('turbolinks:load', function() {
    $('#motion-check').click(function () {
       if( $(this).is('checked') ){
       		$(this).attr('checked', false)
       }else{
       		$(this).attr('checked', true)
       };
    });
});