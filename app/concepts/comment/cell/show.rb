module Comment::Cell
  class Show < Familylegion::Cell::Master

    def show
      cell(Comment::Cell::Discussion, comments)
    end

    def comments
      @comments ||= model.comments.page(page).per(20)
    end

    def page
      context[:page] || 1
    end

    def append
      %{ $("#next").replaceWith("#{j(show)}") }
    end
  end
end
