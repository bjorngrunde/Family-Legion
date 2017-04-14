module Forum::Thread::Cell
  class Show < Forum::Cell::Master

    property  :title
    property  :body

    def body
      model.body.html_safe
    end

    def is_page_one? page
      page == "1" || page == nil
    end

    def pin_icon
      return unless model.pinned
      "<i class='large pin icon'></i> #{t(:thread_is_pinned)}".html_safe
    end

    def lock_icon
      return unless model.is_locked
      "<i class='large lock icon'></i> #{t(:thread_is_locked)}"
    end

    def rank
      model.user.profile.rank.humanize
    end

    def posts
      "#{t(:posts)}: #{post_counter(model.user)}"
    end

    def created_at
      model.created_at.strftime("%d-%m-%Y %H:%M")
    end
  end
end
