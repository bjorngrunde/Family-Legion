module Familylegion::Cell
  class FormError < Familylegion::Cell::Master
    
    def field error
      error.to_s.split(".").last.humanize
    end

    def error_message message
      return message[0].humanize
    end
  end
end
