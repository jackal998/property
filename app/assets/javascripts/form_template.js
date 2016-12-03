$(document).ready(function() {
  $('#ispublic_check').on('change', function(){
    $('#ispublic_schedule').toggleClass('hidden');
  });
  $('#schedule_now').on('change', function(){
    $('#schedule_time').toggleClass('hidden');
  });
});