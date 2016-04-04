// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var contentBlock = $('.content');
var footer = $('.footer');
var header = $('.header');

var messageHeader = $('.details__header');
var messageFooter = $('.details__footer');
var detailsBlock = $('.details');
var messageBox = $('.messages-box');

$(document).ready(function () {
    contentBlock.css('height', $(window).height() - footer.height() - header.height());
    if(messageBox.length) {
        messageBox.css('height', detailsBlock.height() - messageHeader.height() - messageFooter.height() -40);
    }
});
$(window).bind('resize', function () {
    contentBlock.css('height', $(window).height() - footer.height() - header.height());
    if(messageBox.length) {
        messageBox.css('height', contentBlock.height() - messageHeader.height() - messageFooter.height()-40);
    }
});
