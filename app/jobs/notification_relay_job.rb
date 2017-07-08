class NotificationRelayJob < ApplicationJob

  queue_as :default

  def perform(notification)
    html = ApplicationController.render partial: "notifications/partials/#{notification.notifiable_type.underscore.pluralize}", locals: {created_at: notification.created_at, forum_thread_title: forum_thread_title(notification), forum_thread_address: forum_thread_address(notification)}, formats: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  end

  def comment
    "#{notification.notifiable_type}".constantize.find_by(id: notification.notifiable_id)
  end

  def forum_thread_title notification
    comment.forum_thread.title
  end

  def forum_thread_address notification
    forum_show_thread_path(group: comment.forum_group.slug, category: comment.forum_category.slug, thread: comment.forum_thread.slug)
  end
end
