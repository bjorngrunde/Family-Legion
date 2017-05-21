module Event::Cell
  class Filter < Event::Cell::Master

    def select_dungeon
      [[t(:event_dungeon), ""]].concat(Dungeon.all.map { |dungeon| [dungeon.name.humanize, dungeon.id ]})
    end

    def select_difficulty
      [[t(:event_difficulty), ""]].concat(Event.difficulties.map { |difficulty| [difficulty.first.humanize, difficulty.first]})
    end

    def select_event_types
      [[t(:public), :public], [t(:private), :private]]
    end
  end
end
