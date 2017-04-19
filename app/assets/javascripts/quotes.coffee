$(document).on 'turbolinks:load', ->
  if page.controller() == 'forum_threads' && page.action() == "show"

    $('.quote-link').click (event) ->

      text = undefined

      if window.getSelection()
        text = window.getSelection().toString()
      else if document.selection && document.selection.type != "Control" #IE  8/9 Stuff...
        text = document.selection.createRange.text
      else
        alert("You must select a text to quote first!")

      if text.length > 0
        element = document.querySelector('trix-editor')
        element.editor.insertHTML("<blockquote>" + text + "</blockquote>")



