$(document).on 'turbolinks:load', ->
  (->
    createStorageKey = undefined
    host = undefined
    uploadAttachment = undefined
    document.addEventListener 'trix-attachment-add', (event) ->
      attachment = undefined
      attachment = event.attachment
      if attachment.file
        return uploadAttachment(attachment)
      return
    getUrl = window.location
    baseUrl = getUrl.protocol + '//' + getUrl.host
    host = baseUrl + '/image/store/attachment'
    AUTH_TOKEN = $('meta[name=csrf-token]').attr('content')

    uploadAttachment = (attachment) ->
      file = undefined
      form = undefined
      key = undefined
      xhr = undefined
      file = attachment.file
      key = createStorageKey(file)
      form = new FormData
      form.append 'key', key
      form.append 'Content-Type', file.type
      form.append 'authenticity_token', AUTH_TOKEN
      form.append 'file', file
      form.append 'format', 'js'
      xhr = new XMLHttpRequest
      xhr.open 'POST', host, true

      xhr.upload.onprogress = (event) ->
        progress = undefined
        progress = event.loaded / event.total * 100
        attachment.setUploadProgress progress

      xhr.onload = ->
        response = JSON.parse(@responseText)
        if xhr.status == 201
          attachment.setAttributes
            url: response.url
            href: response.url
        else if xhr.status == 422
          errorModal("422: Unprocessable Entity", response.errors)


      xhr.send form

    createStorageKey = (file) ->
      date = undefined
      day = undefined
      time = undefined
      date = new Date
      day = date.toISOString().slice(0, 10)
      time = date.getTime()
      'tmp/' + day + '/' + time + '-' + file.name

    return
  ).call this
