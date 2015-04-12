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
//= require foundation
//= require jquery.price_format.2.0.min
//= require sticky.kit
//= require disqus_rails
//= require_tree .

$(function(){
  $(document).foundation();

  // Price format
  $('.format-price').priceFormat({
    prefix: 'R$ ',
    centsSeparator: ',',
    thousandsSeparator: '.'
  });

  $('.range-slider').foundation('slider', 'set_value', 5000);

  $("#sticky-nav").stick_in_parent();

  $("form.product_filter input").change(function() {
    $('.products-container').fadeTo('slow', 0.2);

    $.get('/?' + $(this).closest('form').serialize(), function(html) {
      $('.products-container').html($(html).find('.products-container').html());
      $('.products-container').fadeTo('slow', 1);
    })
  })
});
