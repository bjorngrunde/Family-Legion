$(document).on 'turbolinks:load', ->

  $('.notification').popup
    inline: true
    hoverable: true
    position: 'bottom right'
    delay:
      show: 300
      hide: 800

  $('#notifications .item').event 'mouseover', (event) ->
    event.preventDefault()
    description = $(event.target).find('.extra')
    icon = description.find(".unhide")

    unless icon.hasClass("unhide")
      adjustCounter()
      i = document.createElement('i')
      i.setAttribute("class", "unhide icon")
      description.append(i)
      description.append(" Seen 2017-02-01")

  adjustCounter = ->
    counter = $('.notification .ui.label')
    val = parseInt counter.text()
    val--
    if val >= 0
      counter.html("<i class='alarm icon'></i>" + val)
