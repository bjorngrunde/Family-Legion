module Forum::Cell
  class Categories < Forum::Cell::Master
    property :title
    property :description

    def link_to_category_page
      link_to model.title.humanize, forum_category_show_path(model.id)
    end
  end
end
