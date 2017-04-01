# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.ui.dropdown').dropdown()
$('.ui.checkbox').checkbox()
$('.group.modal')
  .modal('attach events', '.new.forum.group', 'show')
$('.category.modal')
  .modal('attach events', '.new.forum.category, show')
$('.message .close').on 'click', ->
  $(this).closest('.message').transition 'fade'
  return
