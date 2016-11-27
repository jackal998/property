$(document).ready(function() {
  $('#tag_fold_buttun').click(function(event) {
    $(this).toggleClass('input-group-btn');
    $(this).find('.btn').toggleClass(' glyphicon-console glyphicon-chevron-right');
    $('#tag_input').toggleClass('hidden');
    $('#tag_create_buttun').toggleClass('hidden');
  });
});