module Forum::Group::Cell
  class Collection < Forum::Cell::Master

    def first_row?
      model.id == ForumGroup.first.id
    end
  end
end
