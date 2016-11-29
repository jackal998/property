$(document).ready(function() {
  $('.panel-body').on('click', '#tag_fold_buttun', function(event) {
    event.preventDefault();
    event.stopPropagation();
    $(this).toggleClass('input-group-btn');
    $(this).find('.btn').toggleClass(' glyphicon-console glyphicon-chevron-right');
    $('#tag_input').toggleClass('hidden');
    $('#tag_create_buttun').toggleClass('hidden');
  });

  $('.panel-body').on('click', '#tag_input', function(event) { event.stopPropagation() });
  $('.panel-body').on('click', '#tag_create_buttun', function(event) { event.stopPropagation() });

  $('.panel').on('click', '.panel-body', function(event) {
    if(event.target.tagName != 'A'){
      $('#tags').find('a').toggleClass('btn-danger btn-link');
      if ($('#tags').find('a').attr('data-method') == "delete") {
        $('#tags').find('a').removeAttr('data-method');
        $('#tags').find('a').removeAttr('data-remote');
      } else {
        $('#tags').find('a').attr('data-remote',true);
        $('#tags').find('a').attr('data-method','delete');
      }
    };
  });
});