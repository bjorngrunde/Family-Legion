module Comment::Cell
  class Show < Familylegion::Cell::Master
    include ActionView::Helpers::JavaScriptHelper

    def discussion
      render
    end

    def comments
      @comments ||= model.comments.order(created_at: :desc).page(page).per(2)
    end

    def page
      context[:page] || 1
    end

    def append
      %{ $("#next").replaceWith("#{j(discussion)}") }
    end
  end
end
