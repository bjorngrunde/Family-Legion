module Familylegion::Cell
  class Navigation < Familylegion::Cell::Master

    def notifications
      current_user.notifications.order(created_at: :desc).limit(10)
    end
  end
end
