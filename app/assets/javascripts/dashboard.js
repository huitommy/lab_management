$(document).ready(function(){
  $('.top-bar').load('/nav .top-bar');

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

  var auto_refresh_nav = setInterval(
    function (){
      $('.top-bar').load('/nav .top-bar').fadeIn("slow");
    }, 2000
  );
});
