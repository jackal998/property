$(document).ready(function() {
  $('.panel-body').on('click', '#tag_fold_buttun', function(event) {
    console.log('ppp');
    event.preventDefault();
    $(this).toggleClass('input-group-btn');
    $(this).find('.btn').toggleClass(' glyphicon-console glyphicon-chevron-right');
    $('#tag_input').toggleClass('hidden');
    $('#tag_create_buttun').toggleClass('hidden');
  });
});