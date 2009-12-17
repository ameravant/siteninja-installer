// This script assumes the slideshow is contained within an id of "images".
jQuery(document).ready(function() {
  jQuery('#images').galleryView({
    panel_width: 548,
    panel_height: 300,
    frame_width: 85,
    frame_height: 55,
    overlay_color: '#222',
    overlay_height: 80,
    overlay_text_color: 'white',
    caption_text_color: '#222',
    background_color: '#333',
    nav_theme: 'custom',
    transition_speed: 800
  });
});
jQuery(document).ready(function() {
  jQuery('#images-full').galleryView({
    panel_width: 880,
    panel_height: 600,
    frame_width: 85,
    frame_height: 55,
    overlay_height: 80,
    overlay_color: '#222',
    overlay_text_color: 'white',
    caption_text_color: '#222',
    background_color: '#333',
    nav_theme: 'custom',
    easing: 'easeInOutBack',
    transition_speed: 1000
  });
});
jQuery(document).ready(function() {
    jQuery('#features').galleryView({
    panel_width: 542,
    panel_height: 300,
    frame_width: 85,
    frame_height: 55,
    overlay_color: '#222',
    overlay_height: 80,
    overlay_text_color: 'white',
    caption_text_color: '#222',
    background_color: '#ccc',
    nav_theme: 'custom',
    transition_speed: 800
    });
    });
