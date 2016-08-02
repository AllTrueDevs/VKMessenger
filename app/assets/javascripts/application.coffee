#= require jquery
#= require jquery_ujs
#= require jquery.jplayer

resize = ->
  $('.content').css 'height', $(window).height() - $('.footer').height() - $('.header').height()

$ ->
  resize()
$(window).bind 'resize', ->
  resize()