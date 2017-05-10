module Event::Cell
  class Master < Familylegion::Cell::Master

    def background_image
      image_url("/uploads/#{model.dungeon.image_meta_data[:original][:uid]}")
    end

    def name
      truncate(model.name, length: 25)
    end

    def dungeon
      model.dungeon.name
    end

    def difficulty
      return "PVP" if model.dungeon.dungeon_type == "pvp"
      model.difficulty.humanize
    end

    def guild_event
      "<i class='star icon'></i>#{t(:guild_event)}"
    end

    def public_event
      "<i class='heart icon'></i> #{t(:public_event)}"
    end

    def private_event
      "<i class='protect icon'></i> #{t(:private_event)}"
    end

    def private?
      !public? && !guild_event? && model.id
    end

    def public?
      model.public
    end

    def guild_event?
      model.guild_event
    end

    def can_access?
      model.public || model.guild_event || model.invites.find_by(user_id: current_user.id )
    end

    def is_owner?
      model.user == current_user || current_user.has_role(:admin)
    end
  end
end
