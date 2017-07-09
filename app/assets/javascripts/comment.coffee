$(document).on 'turbolinks:load', ->

  $('#recent-comments').on 'click', '.comment-reply', (e) ->
    e.preventDefault()
    form = $("#" + e.target.getAttribute('data-id')).find('form')
    form.find('textarea').val("")
    form.transition('fade')


  $(document).on 'ajax:success', '.comment-show', (e, data, status, xhr) ->
    id = "#" + e.target.getAttribute('data-id')
    element = $(id)
    element.find(".comment-show").attr('disabled', 'disabled')

  $(document).on 'ajax:success', '#new_comment', (e, data, status, xhr) ->
    $(e.target).find('textarea').val("")

  $(document).on('ajax:success', '#sub_comment', (e, data, status, xhr)->
    element = $("#" + e.target.getAttribute('data-id'))

    commentShow = element.find('.comment-show')
    if !commentShow.hasClass('comment-show')
      commentsLink = newCommentsLink(e.target.getAttribute('data-id'))
      element.find('.actions').append(commentsLink)
    else
      text = commentShow.text()
      numb = parseInt(text.match(/\d+/)) + 1
      text = "<i class='comment icon'></i> Comments(" + numb + ")"
      commentShow.html text


    $(e.target).transition('fade')
    )

  $(document).on 'keypress', '#sub_comment', (e) ->
    code = if e.keyCode then e.keyCode else e.which
    textarea = $(e.target)
    if code == 13 && e.shiftKey
      textarea.value = e.target.value + "<br />"
    else if code == 13
      textarea.submit()
      textarea.value = ""
      return true
    return

newCommentsLink = (id) ->
  tag = document.createElement('a')
  tag.setAttribute('href', '/comments/subcomments/' + id)
  tag.setAttribute('data-id', id)
  tag.setAttribute('class', 'comment-show')
  tag.setAttribute('data-remote', 'true')
  icon = document.createElement('i')
  icon.setAttribute('class', 'comment icon')

  tag.appendChild(icon)

  text = document.createTextNode(' Comments(1)')

  tag.appendChild(text)

  return tag

nl2br = (string) ->
  return (string + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ '<br />' +'$2');

# Might be usefull later
# htmlStr = (htmlStr) ->
#   frag = document.createDocumentFragment()
#   temp = document.createElement('div')
#   temp.innerHTML = htmlStr
#   while temp.firstChild
#     frag.appendChild temp.firstChild
#   frag
