$(document).ready(function(){
  var errorTimeOut = setTimeout(function(){
    $('#flash-messages').fadeOut('slow',function(){
      $(this).remove();
    });
  }, 3500);

  var auto_refresh = setInterval(
    function (){
      $('.activity-feed').load('/dashboard .activity-feed').fadeIn("slow");
    }, 1000
  );
});
