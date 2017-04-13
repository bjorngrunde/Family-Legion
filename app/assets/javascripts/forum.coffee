$(document).on 'turbolinks:load', ->
  if page.controller() == "forum_groups" && page.action() == 'index'

    $('.new.group.modal')
      .modal('attach events', '.new.forum.group', 'show')
    $('.new.category.modal')
      .modal('attach events', '.new.forum.category, show')
    $('.edit.group.modal')
      .modal('attach events', '.edit.forum.group', 'show')
    $('.edit.category.modal')
      .modal('attach events', '.edit.forum.category', 'show')
    $('.wrapper .menu .item')
    .tab()

    $('#edit-group-select').change ->
      group = document.querySelector('#edit-group-select').value
      $('.js-selector').remove()
      baseUrl = getBaseUrl()
      host = baseUrl + '/forum/group/' + group + '/edit'

      auth_token = $('meta[name=csrf-token]').attr('content')

      form = new FormData
      form.append 'authenticity_token', auth_token
      form.append 'format', 'js'

      xhr = new XMLHttpRequest
      xhr.open 'POST', host, true

      xhr.onload = ->
        response = JSON.parse(@responseText)
        if xhr.status == 302
          button = $('.delete-group')
          button.attr('href', button.attr('href') + response.id)
          element = $('.edit.group.form')
          element.attr('action', element.attr("action") + response.id)
          element.find("input#title").attr('value', response.title)
          element.find(".ui.dropdown.selection").dropdown('set selected', response.role)
          $(".wrapper").transition('fade')
        else if xhr.status == 422
          modalErrors(response.errors)

      xhr.send form

    $('#edit-category-select').change ->
      category = document.querySelector('#edit-category-select').value

      $('.js-selector').remove()

      baseUrl = getBaseUrl()
      host = baseUrl + '/forum/category/' + category + '/edit'

      auth_token = $('meta[name=csrf-token]').attr('content')

      form = new FormData
      form.append 'authenticity_token', auth_token
      form.append 'format', 'js'

      xhr = new XMLHttpRequest
      xhr.open 'POST', host, true

      xhr.onload = ->
        response = JSON.parse(@responseText)
        if xhr.status == 302
          button = $('.delete-category')
          button.attr('href', button.attr('href') + response.id)
          element = $('.edit.category.form')
          element.attr('action', element.attr("action") + response.id)
          element.find("input#title").attr('value', response.title)
          element.find("input#description").attr('value', response.description)
          element.find("select#group-id").parent().dropdown('set selected', response.forum_group_id)
          element.find("select#role").parent().dropdown('set selected', response.role)
          $(".wrapper").transition('fade')
        else if xhr.status == 422
          modalErrors(response.errors)

      xhr.send form

  if page.controller() == "forum_threads" && page.action() == "show"

    $('.copy-thread, .move-thread').click (event) ->

      form = document.getElementById("react")
      form.setAttribute('action', event.target.getAttribute('data-path'))

    $('.react.thread.modal')
      .modal('attach events', '.copy-thread', 'show')
      .modal('attach events', '.move-thread', 'show')



    $('#move-category-select').change ->

      category = document.querySelector('#react-category-select').value
      baseUrl = getBaseUrl()
      host = baseUrl + '/forum/category/' + category + '/edit'

      auth_token = $('meta[name=csrf-token]').attr('content')

      form = new FormData
      form.append 'authenticity_token', auth_token
      form.append 'format', 'js'

      xhr = new XMLHttpRequest
      xhr.open 'POST', host, true

      xhr.onload = ->
        response = JSON.parse(@responseText)
        if xhr.status == 302
          $('.forum-group-id').attr('value', response.forum_group_id)
        else if xhr.status == 422
          modalErrors(response.errors)
      xhr.send form

  modalErrors = (errors) ->
    $(".content").append("<div class='ui warning message'><div class='header'>
      Ohh dear!
    </div>
    <h5>"+errors+"</h5>
    The server responded with an error, a report have been sent to our hard working gnomes. Please try reload the page and try again: <br />
    <button onclick='location.reload();' class='ui tiny basic button'><i class='refresh icon'></i> Reload Page</button>
    </div>")

  #Reset current element, accepts element class or id
  resetElement = (element) ->
    document.querySelector(element).load(location.href + " " + element)

  getBaseUrl = ->
    getUrl = window.location
    base = getUrl.protocol + '//' + getUrl.host
    return base
