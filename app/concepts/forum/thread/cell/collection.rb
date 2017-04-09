module Forum::Thread::Cell
  class Collection < Forum::Cell::Master

    def link_to_thread
      link_to model.title, forum_show_thread_path(thread: model.slug, category: model.forum_category.slug, group: model.forum_group.slug, page: 1)
    end

    def author
      model.user.username.humanize
    end
  end
end
