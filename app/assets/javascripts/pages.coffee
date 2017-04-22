# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.ui.dropdown').dropdown()
$('.ui.checkbox').checkbox()
$('.message .close').on 'click', ->
  $(this).closest('.message').transition 'fade'
  return

window.getBaseUrl = ->
  getUrl = window.location
  base = getUrl.protocol + '//' + getUrl.host
  return base

$.fn.event = (name, fn) ->
  @unbind(name).bind name, fn

window.errorModal = (status, errors) ->
  body = document.querySelector('body')

  modal = document.createElement('div')
  modal.classList += "ui small modal ajax-error"

  header = document.createElement('div')
  header.classList += "header"

  status = document.createTextNode(status)
  header.appendChild(status)

  content = document.createElement('div')
  content.classList += "content"

  errors = document.createTextNode(errors)
  content.appendChild(errors)

  actions = document.createElement('div')
  actions.classList += "actions"

  button = document.createElement('div')
  button.classList += "ui red deny button"

  ok = document.createTextNode("OK")
  button.appendChild(ok)

  actions.appendChild(button)

  modal.appendChild(header)
  modal.appendChild(content)
  modal.appendChild(actions)

  body.appendChild(modal)

  $('.ui.small.modal.ajax-error')
    .modal('show')

  return
