module Forum::Comment::Cell
  class Collection < Forum::Cell::Master

    property :body

    def body
      model.body.html_safe
    end
  end
end
