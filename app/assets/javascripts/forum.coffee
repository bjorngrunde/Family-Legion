$('.new.group.modal')
  .modal('attach events', '.new.forum.group', 'show')
$('.new.category.modal')
  .modal('attach events', '.new.forum.category, show')
$('.edit.group.modal')
  .modal('attach events', '.edit.forum.group', 'show')


  $('#edit-group-select').change ->
    select = document.querySelector('#edit-group-select')
    group = select.value

    $('#edit-group-select').parent().remove()

    loader = $('.ui.loader')
    loader.addClass("active")

    getUrl = window.location
    baseUrl = getUrl.protocol + '//' + getUrl.host
    host = baseUrl + '/forum/edit_group/' + group

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
        element.attr('action', element.attr("action")+ "/" + response.id)
        element.find("input#title").attr('value', response.title)
        element.find(".ui.dropdown.selection").dropdown('set selected', response.role)
        element.transition('fade')
      else if xhr.status == 422
        alert(response.errors)

    xhr.send form
