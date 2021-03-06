module Event::Cell
  class Form < Event::Cell::Master

    def dungeons_select
      Dungeon.all.map { |dungeon| [dungeon.name, dungeon.id] }
    end

    def difficulty_select
      Event.difficulties.map { |difficulty| [difficulty.first.capitalize, difficulty.first]}
    end

    def users_select
      User.all.map { |user| [user.username.humanize, user.id ] unless user == current_user }
    end

    def hidden_class
      return "hidden" if public? || guild_event?
    end
  end
end
