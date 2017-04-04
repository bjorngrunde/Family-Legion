$('.new.group.modal')
  .modal('attach events', '.new.forum.group', 'show')
$('.new.category.modal')
  .modal('attach events', '.new.forum.category, show')
$('.edit.group.modal')
  .modal('attach events', '.edit.forum.group', 'show')
$('.edit.category.modal')
  .modal('attach events', '.edit.forum.category', 'show')


$('#edit-group-select').change ->
  select = document.querySelector('#edit-group-select')
  group = select.value

  $('.js-selector').remove()

  loader = $('.ui.loader')
  loader.addClass("active")

  getUrl = window.location
  baseUrl = getUrl.protocol + '//' + getUrl.host
  host = baseUrl + '/forum/edit/group/' + group

  auth_token = $('meta[name=csrf-token]').attr('content')

  form = new FormData
  form.append 'authenticity_token', auth_token
  form.append 'format', 'js'

  xhr = new XMLHttpRequest
  xhr.open 'POST', host, true

  xhr.onload = ->
    response = JSON.parse(@responseText)
    if xhr.status == 302
      loader.removeClass('active')
      loader.addClass('hidden')
      element = $('.edit.group.form')
      element.attr('action', element.attr("action")+ "update/group/" + response.id)
      element.find("input#title").attr('value', response.title)
      element.find(".ui.dropdown.selection").dropdown('set selected', response.role)
      element.transition('fade')
    else if xhr.status == 422
      modalErrors(response.errors)

  xhr.send form

$('#edit-category-select').change ->
  select = document.querySelector('#edit-category-select')
  category = select.value

  $('.js-selector').remove()

  loader = $('.ui.loader')
  loader.addClass("active")

  getUrl = window.location
  baseUrl = getUrl.protocol + '//' + getUrl.host
  host = baseUrl + '/forum/edit/category/' + category

  auth_token = $('meta[name=csrf-token]').attr('content')

  form = new FormData
  form.append 'authenticity_token', auth_token
  form.append 'format', 'js'

  xhr = new XMLHttpRequest
  xhr.open 'POST', host, true

  xhr.onload = ->
    response = JSON.parse(@responseText)
    if xhr.status == 302
      loader.removeClass('active')
      loader.addClass('hidden')
      element = $('.edit.category.form')
      element.attr('action', element.attr("action")+ "update/category/" + response.id)
      element.find("input#title").attr('value', response.title)
      element.find("input#description").attr('value', response.description)
      element.find("select#group-id").parent().dropdown('set selected', response.forum_group_id)
      element.find("select#role").parent().dropdown('set selected', response.role)
      element.transition('fade')
    else if xhr.status == 422
      modalErrors(response.errors)

  xhr.send form


modalErrors = (errors) ->
  $(".content").append("<div class='ui warning message'><div class='header'>
    Ohh dear!
  </div>
  The server responded with an error, a report have been sent to our hard working gnomes. Please try reload the page and try again: <br />
  <button onclick='location.reload();' class='ui tiny basic button'><i class='refresh icon'></i> Reload Page</button>
  </div>")

#Reset current element, accepts element class or id
resetElement = (element) ->
  document.querySelector(element).load(location.href + " " + element)


