$(document).ready(function() {
  $('#new_obj_btn').click(function(event) {
    $(this).toggleClass('btn-primary btn-default active');
    $('#form_template').toggleClass('hidden');
  });
});