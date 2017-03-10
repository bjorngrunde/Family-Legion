module Familylegion::Cell
  class FormError < Familylegion::Cell::Master
    
    def field error
      error.to_s.split(".").last.humanize
    end

    def error_message message
      return t(message) if message.instance_of? Symbol
      message.gsub!(" ", "_") if message.is_a?(String)
      message.downcase! if message.is_a?(String)
      t(message.split(".").last.to_sym)
    end
  end
end
