module Forum::Category::Cell
  class Show < Forum::Cell::Master

    def create_thread_link
      link_to "<i class='write icon'></i>", forum_new_thread_path(group: model.forum_group.slug, category: model.slug), class: "circular ui green icon button", data: { tooltip: t(:create_thread)}
    end

  end
end
