// Fancybox can be used on any link on the site, simply specify a class of "fancy". Add "rel" attribute to grouped links.
jQuery(document).ready(function() {
  jQuery("a.fancy").fancybox({ 
    'zoomSpeedIn': 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': true,
    'easingOut': 'easeOutQuad',
    'easingIn': 'easeInQuad'
  }); 
}); 
