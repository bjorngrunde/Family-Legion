module Comment::Cell
  class Discussion < Comment::Cell::Show
    include ActionView::Helpers::JavaScriptHelper

    def created_at
      super
    end

    def comment
      render
    end

    def append
      %{ $("#recent-comments").prepend("#{j(comment)}") }
    end
  end
end
