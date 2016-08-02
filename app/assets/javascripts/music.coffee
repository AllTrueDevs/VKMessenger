$ ->
  mediaPlayer = $('#mediaContainer')
  mediaPlayer.jPlayer ready: ->
    jQuery(this).jPlayer 'setMedia', mp3: '/audio/track.mp3'
  $('.music-list__but_play').click ->
    if $(this).text() == 'Play'
      $('.music-list__but_play').each ->
        $(this).text 'Play'
        return
      $(this).text 'Pause'
      if $('#mediaContainer audio').attr('src') != $(this).data('url')
        $('#mediaContainer').jPlayer 'setMedia', mp3: $(this).data('url')
      $('#mediaContainer').jPlayer 'play'
    else
      $('.music-list__but_play').each ->
        $(this).text 'Play'
        return
      $('#mediaContainer').jPlayer 'pause'

  $('.music-list__but_pause').click ->
  $('.music-list__but_stop').click ->
    $('.music-list__but_play').each ->
      $(this).text 'Play'
    $('#mediaContainer').jPlayer 'stop'
