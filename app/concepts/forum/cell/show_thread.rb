module Forum::Cell
  class ShowThread < Forum::Cell::Master

    property  :title
    property  :body

    def body
      model.body.html_safe
    end
  end
end
