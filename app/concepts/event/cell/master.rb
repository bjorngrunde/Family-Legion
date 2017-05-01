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

    def author
      "#{t(:created_by)}: #{image_tag(model.user.profile.thumbnail, class: 'ui avatar image')} #{profile_link model.user}"
    end

    def private?
      !model.guild_event && !model.public
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
  end
end
