module Familylegion::Cell
  class FormError < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation

    def field error
      error.to_s.split(".").last.humanize
    end

    def error_message message
      return message[0].humanize
    end
  end
end
