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
  jQuery(".fancy-iframe").fancybox({ 
    'zoomSpeedIn': 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': 'true',
    'easingOut': 'easeOutQuad',
    'easingIn': 'easeInQuad',
    'type': 'iframe',
    'width': 910,
    'autoScale': true,
    'height':"90%"
  });
  jQuery(".fancy-iframe-small").fancybox({ 
    'zoomSpeedIn': 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': 'true',
    'easingOut': 'easeOutQuad',
    'easingIn': 'easeInQuad',
    'type': 'iframe',
    'width': 480,
    'autoScale': true,
    'height':270
  });
  jQuery(".fancy-iframe-medium").fancybox({ 
    'zoomSpeedIn': 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': 'true',
    'easingOut': 'easeOutQuad',
    'easingIn': 'easeInQuad',
    'type': 'iframe',
    'width': 608,
    'autoScale': true,
    'height':368
  });
  jQuery(".fancy-iframe-large").fancybox({ 
    'zoomSpeedIn': 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': 'true',
    'easingOut': 'easeOutQuad',
    'easingIn': 'easeInQuad',
    'type': 'iframe',
    'width': 864,
    'autoScale': true,
    'height':486
  });
  jQuery(".fancy-inline").fancybox({ 
    'zoomSpeedIn': 300,
    'zoomSpeedOut': 300,
    'overlayShow': true,
    'hideOnContentClick': false,
    'hideOnOverlayClick': false,
    'type': 'inline',
    'showCloseButton' : false,
    'autoScale': true
  }); 
}); 