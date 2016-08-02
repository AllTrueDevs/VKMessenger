resize = ->
  if $('.messages-box').length
    $('.messages-box').css 'height', $('.details').height() - $('.details__header').height() - $('.details__footer').height() - 40

$ ->
  resize()
$(window).bind 'resize', ->
  resize()