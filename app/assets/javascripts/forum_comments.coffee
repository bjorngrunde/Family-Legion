$(document).on 'turbolinks:load', ->
  if page.controller() == 'forum_threads' && page.action() == "show"

    #init code highligher
    $('pre').each (i, block) ->
      hljs.highlightBlock block
      return

    #Get editor

    element = document.querySelector('trix-editor')

    #Check if editor is in storage

    if localStorage["editorState"]
      element.editor.loadJSON(JSON.parse(localStorage["editorState"]))

    #Store the editors document in case of requesting new page

    $('.page, .last, .next, .prev, .first').event 'click', ->

      localStorage["editorState"] = JSON.stringify(element.editor)

      return true

    #clear storage if form submit

    $('#reply-to-thread').event 'submit', ->

      if localStorage["editorState"]
        localStorage.removeItem("editorState")

      return true


    #Add quotes to editor

    $('.quote-link').event 'click', (event) ->
      event.preventDefault()

      unless element.editor
        element = document.querySelector('trix-editor')

      event.target.className += ' quoted'
      comment_or_thread = event.target.getAttribute('data-id')
      model = event.target.getAttribute('data-type')

      baseUrl = getBaseUrl()

      if model == "ForumComment"
        host = baseUrl + '/forum/comment/' + comment_or_thread + '/quote'
      else
        host = baseUrl + '/forum/thread/' + comment_or_thread + '/quote'

      auth_token = $('meta[name=csrf-token]').attr('content')

      form = new FormData
      form.append 'authenticity_token', auth_token
      form.append 'format', 'js'

      xhr = new XMLHttpRequest
      xhr.open 'POST', host, true

      xhr.onload = ->
        response = JSON.parse(@responseText)

        if xhr.status == 302
          user =  '<a href="/profile/' + response.user.username + '" >@' + response.user.username + '</a>'
          body = "<blockquote>" + response.body + "</blockquote>"

          #yeah we need a few linebreaks to avoid quotes in quotes..quoteception?
          element.editor.insertLineBreak()
          element.editor.insertHTML(body)
          element.editor.insertHTML(user)
          length = element.editor.getDocument().toString().length
          element.editor.setSelectedRange(length - 1)
          element.editor.insertLineBreak()
          element.editor.insertLineBreak()

        if xhr.status == 422
          errorModal("422: Unprocessable Entity", response.error)

      xhr.send form


    $(".clear-form").event 'click', (event) ->
      event.preventDefault()

      length = element.editor.getDocument().toString().length
      element.editor.setSelectedRange([0, length - 1])
      element.editor.deleteInDirection("backward")

      if localStorage["editorState"]
        localStorage.removeItem("editorState")

      quotedElements = document.querySelectorAll('.quoted')

      for element in quotedElements
        element.classList.remove('quoted')
      return


    #Quickly scroll to comment form
    $('.reply-link').event 'click', (event) ->
      event.preventDefault()
      $('html, body').animate { scrollTop: $('#reply-to-thread').offset().top }, 1000
