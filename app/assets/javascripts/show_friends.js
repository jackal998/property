$(document).ready(function() {
  $('[id^=friend_]').click(function(event) {
    $(this).find('[id^=delete_]').toggleClass('hidden');
  });
  $('[id^=friend_]').find('a').click(function(event) {
    event.stopPropagation()
  });
});