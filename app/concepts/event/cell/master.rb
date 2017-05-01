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
      "<i class='star icon'></i>#{t(:Guild_Event)}" if model.guild_event
    end
  end
end
