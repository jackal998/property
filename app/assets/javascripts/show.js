$(document).ready(function() {
  $('#tag_fold_buttun').click(function(event) {
    $(this).toggleClass('input-group-btn');
    $(this).find('.btn').toggleClass('glyphicon-plus glyphicon-minus');
    $('#tag_input').toggleClass('hidden');
    $('#tag_create_buttun').toggleClass('hidden');
  });
});