$(document).on 'turbolinks:load', ->

  $(document).on 'click', '.comment-reply', (e) ->
    e.preventDefault()
    form = $("#" + e.target.getAttribute('data-id')).find('form')
    form.transition('fade')


  $(document).on 'click', '.comment-show', (e) ->
    e.preventDefault()
    element = $("#" + e.target.getAttribute('data-id') )
    element = element.find(".comments")
    element.transition('fade')

  $("#new_comment").on('ajax:success', (e, data, status, xhr) ->
    element = $("#recent-comments")
    comment = decorateSingleComment(data)
    element.prepend(comment)
    val = $('#comment_body').val("")
  )

  $("#sub_comment").on('ajax:success', (e, data, status, xhr)->
    element = $("#" + e.target.getAttribute('data-id'))
    comment_tag = element.find(".comments")
    console.log(comment_tag)

    if !comment_tag.hasClass('comments')
      comment_tag = newCommentsTag()
      comment_tag.append(decorateSingleComment(data, true))
      element.append(comment_tag)
    else
      comment_tag.append(decorateSingleComment(data, true))

    $(e.target).transition('fade')
    )




decorateComments = (comments) ->
  commentList = []

  comments.forEach (comment) ->
    commentList.push(commentTemplate(comment))

  return commentList

decorateSingleComment = (comment, sub_reply = false) ->
  return commentTemplate(comment, sub_reply)

newCommentsTag = ->
  tag = document.createElement('div')
  tag.setAttribute('class', 'comments')
  return tag

commentTemplate = (comment, sub_reply = false) ->
   #Create the container for our comment
    container = document.createElement('div')
    container.setAttribute('class', 'comment')
    container.setAttribute('id', comment.id)

    #create our avatar
    avatar = document.createElement('div')
    avatar.setAttribute('class', 'avatar')

    #create our image tag for avatar
    image = document.createElement('img')
    image.setAttribute('src', comment.user.profile.thumbnail)
    image.setAttribute('class', 'ui avatar image')
    #append image to our avatar container
    avatar.appendChild(image)

    #append avatar to container
    container.appendChild(avatar)

    #content container for data
    content = document.createElement('div')
    content.setAttribute('class', 'content')

    #create author container
    author = document.createElement('div')
    author.classList.add('author')

    #create user link
    profile_link = document.createElement('a')
    profile_link.setAttribute('href', '/profile/' + comment.user.username)
    profile_link.setAttribute('data-turbolinks', false)
    profile_link.setAttribute('class', comment.user.profile.klass)
    user = document.createTextNode(comment.user.username)

    #create meta data
    meta_data = document.createElement('div')
    meta_data.setAttribute('class', 'metadata')
    span = document.createElement('span')
    span.setAttribute('class', 'date')
    date = document.createTextNode(comment.created_at)

    #Append author to content
    span.appendChild(date)
    meta_data.appendChild(span)
    profile_link.appendChild(user)
    author.appendChild(profile_link)
    author.appendChild(meta_data)
    content.appendChild(author)

    #create text content
    text = document.createElement('div')
    text.setAttribute('class', 'text')
    body = htmlStr(comment.body)

    #append text to content
    text.appendChild(body)
    content.appendChild(text)

    #create actions
    if sub_reply == false
      actions = document.createElement('div')
      actions.setAttribute('class', 'actions')

      #create reply action
      reply_link = document.createElement('a')
      reply_link.setAttribute('class', 'comment-reply')
      reply_link.setAttribute('href', '#')
      reply_text = document.createTextNode('Reply')

      reply_icon = document.createElement('i')
      reply_icon.setAttribute('class', 'reply icon')

      #append actions
      reply_link.appendChild(reply_icon)
      reply_link.appendChild(reply_text)
      actions.appendChild(reply_link)
      content.appendChild(actions)

    container.appendChild(content)

    return container


htmlStr = (htmlStr) ->
  frag = document.createDocumentFragment()
  temp = document.createElement('div')
  temp.innerHTML = htmlStr
  while temp.firstChild
    frag.appendChild temp.firstChild
  frag
