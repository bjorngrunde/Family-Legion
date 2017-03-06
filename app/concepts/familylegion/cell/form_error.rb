module Familylegion::Cell
  class FormError < Familylegion::Cell::Master
    
    def field error
      error.to_s.split(".").last.humanize
    end

    def error_message message
      return t(message) if message.instance_of? Symbol
      t(message.split(".").last.to_sym)
    end
  end
end
