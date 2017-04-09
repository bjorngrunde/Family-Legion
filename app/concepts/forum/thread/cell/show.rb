module Forum::Thread::Cell
  class Show < Forum::Cell::Master

    property  :title
    property  :body

    def body
      model.body.html_safe
    end

    def is_owner? user
      model.user.id == user.id
    end

    def is_page_one? page
      page == "1" || page == nil
    end

    def reply_link
      link_to "<i class='reply icon'></i> #{t(:reply)}", forum_new_comment_path(group: model.forum_group.slug, category: model.forum_category.slug, thread: model.slug), class: "ui tiny alliance button", data: { tooltip: t(:respond_with_comment), position: "top center"}
    end

    def subscription_link
      link_to "<i class='bookmark icon'></i> #{t(:subscribe)}", "#", class: "ui tiny alliance button"
    end
  end
end
