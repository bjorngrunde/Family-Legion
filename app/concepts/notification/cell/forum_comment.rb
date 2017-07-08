module Notification::Cell
  class ForumComment < Familylegion::Cell::Master

    def comment
      "#{model.notifiable_type}".constantize.find_by(id: model.notifiable_id)
    end

    def created_at
      model.created_at
    end

    def forum_thread_title
      comment.forum_thread.title
    end

    def forum_thread_address
      forum_show_thread_path(group: comment.forum_group.slug, category: comment.forum_category.slug, thread: comment.forum_thread.slug)
    end
  end
end
