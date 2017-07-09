module Familylegion::Cell
  class Flash < Familylegion::Cell::Master

    def flash_class(level)
      case level.to_sym
      when :positive then "positive"
      when :negative then "negative"
      when :warning  then "warning"
      when :info     then "info"
      end
    end

  end
end
