$(document).on 'turbolinks:load', ->
    $(".datepicker").pickadate()
    $(".timepicker").pickatime({ format: 'H:i' })

    $('.fluid.event.card').dimmer on: 'hover'

    $('.public-event, .guild-event').event 'change', (e) ->

      if e.target.checked
        $('.selector.transition').transition("hide")
      else
        if $('.public-event').parent().hasClass('checked') || $('.guild-event').parent().hasClass('checked')
          return
        else
          $('.selector.transition').transition("fade up")

    $('.delete-event.modal').modal('attach events', '#delete-event', 'show')
