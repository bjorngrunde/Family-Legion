module ForumCommentsNotificationHelper

  def comment notification
    "#{notification.notifiable_type}".constantize.find_by(id: notification.notifiable_id)
  end

  def forum_thread_title obj
    model = comment(obj)
    model.forum_thread.title
  end

  def forum_thread_address obj
    model = comment(obj)
    forum_show_thread_path(group: model.forum_group.slug, category: model.forum_category.slug, thread: model.forum_thread.slug)
  end
end
