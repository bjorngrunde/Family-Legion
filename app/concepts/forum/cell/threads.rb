module Forum::Cell
  class Threads < Forum::Cell::Master

    def link_to_thread
      link_to model.title, forum_show_thread_path(url: model.url, forum_category_id: model.forum_category.id)
    end

    def author
      model.user.username.humanize
    end
  end
end
