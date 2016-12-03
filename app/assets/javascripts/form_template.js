$(document).ready(function() {
  $('#ispublic_check').on('change', function(){
    $('#ispublic_schedule').toggleClass('hidden');
  });
});