module Event::Cell
  class SignUp < Event::Cell::Master

    def select_roles
      Invite.roles.map { |role| [role.first.humanize, role.first] }
    end

    def select_statuses
      Invite.statuses.map { |status| [status.first.humanize, status.first ]}
    end

    def invite_model
      context[:invite]
    end
  end
end
