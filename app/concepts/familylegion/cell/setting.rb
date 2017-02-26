module Familylegion::Cell
  class Setting < Familylegion::Cell::Master

    def rendered_cell
      "Setting::Cell::#{context[:cell_view]}".constantize
    end
  end
end