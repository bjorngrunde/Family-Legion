module Forum::Thread::Cell
  class Collection < Forum::Cell::Master

    def link_to_thread
      link_to truncate(pinned_or_locked_thread?(model.title), length: 50), forum_show_thread_path(thread: model.slug, category: model.forum_category.slug, group: model.forum_group.slug, page: 1), data: { tooltip: model.title }
    end

    def author
      profile_link model.user
    end

    def pinned_or_locked_thread? title
      return title unless model.pinned || model.is_locked
      pin_icon = "<i class='pin icon'></i>"
      locked_icon = "<i class='lock icon'></i>"
      string = ""
      string << pin_icon if model.pinned
      string << locked_icon if model.is_locked
      string << "#{title}"
    end

    def updated_at
      super
    end

    def comments
      model.forum_comments_count || "0"
    end

    def views
      model.views.size
    end
  end
end
