module Dungeon::Cell
  class Collection < Familylegion::Cell::Master

    def name
      model.name.titleize
    end

    def dungeon
      model.dungeon_type.humanize
    end

    def created_at
      super
    end
  end
end
