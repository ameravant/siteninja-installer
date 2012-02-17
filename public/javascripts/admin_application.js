// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function form_submitted(submit_message) {
  $$('div.submit input')[0].disabled = true;
  $('submit_spinner').show();
  if ($('submit_cancel')) $('submit_cancel').hide();
  $('submit_message').innerHTML = (submit_message ? submit_message : "One moment...");
}

function comment_reply(name) {
  $('comment_comment').value = name + ': ';
  $('comment_name').focus();
}

jQuery(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});
function initHelp() {
  jQuery('a.help-tips').click(function() {
	jQuery(this).next('div.help-tips').fadeIn('fast');
	return false;
    }
  );
  jQuery('div.help-tips img').click(function() {
	jQuery(this).parent('div.help-tips').fadeOut('fast');
	return false;
    }
  );
 }

jQuery(document).ready(function () {
  initHelp();
  }
);

jQuery(window).resize(function(){
  setWidth();
  });
jQuery(document).ready(function(){
  setWidth();
  });
function setWidth() {
  if(jQuery(window).width() <= 699 || screen.width <= 699) {
    jQuery('body').attr('class','small-screen jsenabled')
  }
  else if(jQuery(window).width() <= 1024 || screen.width <= 1024){
    jQuery('body').attr('class','medium-screen jsenabled')
  }
  else{
    jQuery('body').attr('class','full-screen jsenabled')
  }
    jQuery('#top-margin').css('height', jQuery('#admin-menu').height());
  }