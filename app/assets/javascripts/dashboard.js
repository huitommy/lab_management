$(document).ready(function(){
  $('.top-bar').load('/nav .top-bar');

  var errorTimeOut = setTimeout(function(){
    $('#flash-messages').fadeOut('slow',function(){
      $(this).remove();
    });
  }, 2000);

  var auto_refresh = setInterval(
    function (){
      $('.activity-feed').load('/dashboard .activity-feed').fadeIn("slow");
    }, 1000
  );

  var auto_refresh_nav = setInterval(
    function (){
      $('.top-bar').load('/nav .top-bar').fadeIn("slow");
    }, 10000
  );
});
