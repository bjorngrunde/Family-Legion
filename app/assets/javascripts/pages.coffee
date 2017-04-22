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
