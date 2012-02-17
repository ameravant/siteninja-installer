function comment_reply(name) {
  // re-written as jQuery
  // pre-fill comment field with name of person being responded to.
  $('#comment_comment').val(name + ': ');
  $('#comment_name').trigger('focus');
  //$('comment_comment').value = name + ': ';
  //$('comment_name').focus();
}

$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});
function initHelp() {
  $('a.help-tips').click(function() {
	$(this).next('div.help-tips').fadeIn('fast');
	return false;
    }
  );
  $('div.help-tips img').click(function() {
	$(this).parent('div.help-tips').fadeOut('fast');
	return false;
    }
  );
 }

$(document).ready(function () {
  initHelp();
  }
);

$(window).resize(function(){
  setWidth();
  });
$(document).ready(function(){
  setWidth();
  });
function setWidth() {
  if($(window).width() <= 699 || screen.width <= 699) {
    $('body').attr('class','small-screen jsenabled')
  }
  else if($(window).width() <= 1024 || screen.width <= 1024){
    $('body').attr('class','medium-screen jsenabled')
  }
  else{
    $('body').attr('class','full-screen jsenabled')
  }
    $('#top-margin').css('height', $('#admin-menu').height());
  }