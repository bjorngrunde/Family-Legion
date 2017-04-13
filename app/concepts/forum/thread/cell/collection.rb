module Forum::Thread::Cell
  class Collection < Forum::Cell::Master

    def link_to_thread
      link_to pinned_thread?(model.title), forum_show_thread_path(thread: model.slug, category: model.forum_category.slug, group: model.forum_group.slug, page: 1)
    end

    def author
      model.user.username.humanize
    end

    def pinned_thread? title
      return title unless model.pinned
      "<i class='pin icon'></i> #{title}"
    end

    def updated_at
      "#{time_ago_in_words(model.updated_at)}"
    end
  end
end
