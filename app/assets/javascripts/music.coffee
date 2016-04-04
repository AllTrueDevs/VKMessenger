$ ->
  mediaPlayer = $('#mediaContainer')
  mediaPlayer.jPlayer
    ready: ->
      $(this).jPlayer 'setMedia',
        mp3: 'kek'
  $('.playButton').click ->
    if $('#mediaContainer audio').attr('src') != $(this).data('url')
      $('#mediaContainer').jPlayer 'setMedia',
        mp3: $(this).data('url')
    $('#mediaContainer').jPlayer 'play'
  $('.pauseButton').click ->
    $('#mediaContainer').jPlayer 'pause'
  $('.stopButton').click ->
    $('#mediaContainer').jPlayer 'stop'
