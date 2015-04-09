// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.jcrop
//= require papercrop
//= require dropzone
//= require_tree .

$(document).ready(function() {
  jQuery.fn.center = function (img_width, img_height) {
    var img_h = $(this).outerHeight();
    var img_w = $(this).outerWidth();
    // half of the toolbars height to account for it
    var toolbar_height = 25;
    if (img_h == 0) {
      img_h = parseInt(img_height);
    }
    if (img_w == 0) {
      img_w = parseInt(img_width);
    }
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - img_h) / 2) + 
                                                $(window).scrollTop() + toolbar_height) + "px");
    this.css("left", Math.max(0, (($(window).width() - img_w) / 2) + 
                                                $(window).scrollLeft()) + "px");
    window.onresize = function(event) { 
      centerImage();
    };
    return this;
  }
  return centerImage();
});



centerImage = function(e) {
  console.log('image is being checked');
  var image = $('#js-center-image');
  var width = image[0].dataset.width;
  var height = image[0].dataset.height;
  if (image.length > 0) {
    image.center(width, height);
  }
};

