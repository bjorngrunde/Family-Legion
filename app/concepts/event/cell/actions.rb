module Event::Cell
  class Actions < Event::Cell::Master

    def select_players
      model.invites.map { |invite| [invite.user.username.humanize, invite.id] unless invite.status == "selected" }
    end
  end
end
