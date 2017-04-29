# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
$(document).on 'turbolinks:load', ->
  if page.controller() == 'profiles' && page.action() == "show"
    body = document.querySelector('body')
    script= document.createElement('script');
    script.type= 'text/javascript'
    script.src= '//wow.zamimg.com/widgets/power.js'
    body.appendChild(script)
