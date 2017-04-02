module Forum::Cell
  class Categories < Forum::Cell::Master
    property :title
    property :description

    def link_to_category_page
      link_to model.title.humanize, forum_category_show_path(id: model.id, page: 1)
    end
  end
end
