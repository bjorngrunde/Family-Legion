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
  end
end
