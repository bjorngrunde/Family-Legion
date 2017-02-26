module Familylegion::Cell
  class Master < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation

    def current_user
      context[:current_user]
    end

    def form
      context[:form]
    end
  end
end