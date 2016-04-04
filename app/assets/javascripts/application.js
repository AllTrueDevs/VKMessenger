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
//= require jquery.jplayer
//= require jquery
//= require_tree .

var contentBlock = $('.content');
var footer = $('.footer');
var header = $('.header');

var messageHeader = $('.details__header');
var messageFooter = $('.details__footer');
var detailsBlock = $('.details');
var messageBox = $('.messages-box');

main = function() {
    
    contentBlock.css('height', $(window).height() - footer.height() - header.height());
    if(messageBox.length) {
        messageBox.css('height', detailsBlock.height() - messageHeader.height() - messageFooter.height() -40);
    }
    var mediaPlayer = $('#mediaContainer');

    mediaPlayer.jPlayer({
        ready: function() {jQuery(this).jPlayer("setMedia", {
            mp3: '/audio/track.mp3'
        });}

    });
    $('.playButton').click(function() {
        if ($('#mediaContainer audio').attr('src') != $(this).data('url')){
            $('#mediaContainer').jPlayer('setMedia', {
                mp3: $(this).data('url')});
        }
        $('#mediaContainer').jPlayer('play');
    });
    $('.pauseButton').click(function() {
        $('#mediaContainer').jPlayer('pause');
    });
    $('.stopButton').click(function() {
        $('#mediaContainer').jPlayer('stop');
    });

};
$(document).ready(main);
$(document).on('page:load', main);

$(window).bind('resize', function () {
    contentBlock.css('height', $(window).height() - footer.height() - header.height());
    if(messageBox.length) {
        messageBox.css('height', contentBlock.height() - messageHeader.height() - messageFooter.height()-40);
    }
});
