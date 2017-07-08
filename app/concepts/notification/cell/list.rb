module Notification::Cell
  class List < Familylegion::Cell::Master

    def render_cell
      "Notification::Cell::#{model.notifiable_type}".constantize
    end
  end
end
