module Event::Cell
  class Column < Event::Cell::Master

    def joined
      "#{model.invites.joined.count} joined"
    end
  end
end
