module Familylegion::Cell
  class Navigation < Familylegion::Cell::Master

    def notifications
      current_user.notifications.order(created_at: :desc).unread.limit(20)
    end

    def notifier_css_class
      notifications.count > 0 ? "red" : "black"
    end
  end
end
