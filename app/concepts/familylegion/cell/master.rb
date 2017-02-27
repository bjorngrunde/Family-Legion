module Familylegion::Cell
  class Master < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper
    
    def current_user
      context[:current_user]
    end

    def form
      context[:form]
    end

    def model_css_class
      "#{model.profile.klass.sub("_", "-")}"
    end

    def current_user_css_class
      "#{current_user.profile.klass.sub("_", "-")}"
    end
  end
end