module Event::Cell
  class Actions < Event::Cell::Master

    def select_players
      [[t(:select_players), ""]].concat model.invites.not_declined.map { |invite| [invite.user.username.humanize, invite.id]}
    end
  end
end