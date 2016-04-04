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

main = function() {
    $('.content').css('min-height', $(window).height() - $('.footer').height() - $('.header').height());

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
    $('.content').css('min-height', $(window).height() - $('.footer').height() - $('.header').height());
});
