App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    counter = $('.notification .ui.black.label')
    val = parseInt counter.text()
    val++
    counter.addClass('red')
    counter.html("<i class='alarm icon'></i>" + val)
    $("#notifications").prepend(data.html)
