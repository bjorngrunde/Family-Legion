module Comment::Cell
  class Discussion < Comment::Cell::Show

    def created_at
      super
    end

  end
end
