module Event::Cell
  class SignUp < Event::Cell::Master

    def select_roles
      Invite.roles.map { |role| [role.first.humanize, role.first] }
    end

    def select_statuses
      Invite.statuses.map { |status| [status.first.humanize, status.first ] unless status.first == "selected" }
    end

    def invite_model
      context[:invite]
    end

    def invited?
      return false unless private?
      return false unless invite = current_user.invites.find_by(inviteable_id: model.id, inviteable_type: model.class.name)
      return false unless invite.role.nil?
      true
    end
  end
end
