module Forum::Category::Cell
  class Show < Forum::Cell::Master

    def create_thread_link
      link_to "<i class='write icon'></i> #{t(:new_thread)}", forum_new_thread_path(group: model.forum_group.slug, category: model.slug), class: "forum action", data: { tooltip: t(:create_thread)}
    end

  end
end
