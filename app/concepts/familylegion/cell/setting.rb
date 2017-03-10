module Familylegion::Cell
  class Setting < Familylegion::Cell::Master

    def rendered_cell
      "#{context[:cell_view]}".constantize
    end
  end
end