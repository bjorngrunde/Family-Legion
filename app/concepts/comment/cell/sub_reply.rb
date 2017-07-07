module Comment::Cell
  class SubReply < Comment::Cell::Show
    include ActionView::Helpers::JavaScriptHelper

    def comment
      render
    end

    def append
      %{ $("#" + "#{model.commentable_id}").find(".comments").append("#{j(comment)}") }
    end

    def prepend
      %{ $("#" + "#{model.commentable_id}").find(".comments").prepend("#{j(comment)}"); }
    end
  end
end
