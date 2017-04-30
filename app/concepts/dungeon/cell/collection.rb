module Dungeon::Cell
  class Collection < Familylegion::Cell::Master

    def name
      model.name
    end

    def dungeon
      model.dungeon_type.humanize
    end

    def created_at
      super
    end

    def edit_link
      link_to "<i class='edit icon'></i> #{t(:edit)}", edit_admin_dungeon_path(model)
    end

    def delete_link
      link_to "<i class='delete icon'></i> #{t(:delete)}", admin_dungeon_path(model), method: :delete
    end
  end
end
