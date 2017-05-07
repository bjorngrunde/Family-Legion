$(document).on 'turbolinks:load', ->
    $(".datepicker").pickadate()
    $(".timepicker").pickatime({ format: 'H:i' })

    $('.fluid.event.card').dimmer on: 'hover'

    $('.public-event').event 'change', (e) ->

      if e.target.checked
        $('.selector.transition').transition("hide")
      else
        $('.selector.transition').transition("fade up")
