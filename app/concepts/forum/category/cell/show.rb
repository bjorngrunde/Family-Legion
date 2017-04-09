module Forum::Category::Cell
  class Show < Forum::Cell::Master

    def create_thread_link
      link_to t(:create_thread), forum_new_thread_path(group: model.forum_group.slug, category: model.slug), class: "ui tiny alliance button"
    end

  end
end
