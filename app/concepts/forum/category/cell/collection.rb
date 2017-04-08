module Forum::Category::Cell
  class Collection < Forum::Cell::Master

    property :title
    property :description

    def link_to_category_page
      link_to model.title.humanize, forum_show_category_path(group: model.forum_group.slug, category: model.slug, page: 1)
    end

    def latest_activity
      thread = model.forum_threads.order(:updated_at).last
      return "#{time_ago_in_words(thread.updated_at)} ago".humanize unless thread.nil?
      t(:no_activity_yet)
    end

    def thread_counter
      model.forum_threads.count
    end
  end
end
