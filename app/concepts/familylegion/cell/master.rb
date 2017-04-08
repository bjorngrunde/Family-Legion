module Familylegion::Cell
  class Master < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::FormOptionsHelper
    include Kaminari::Cells

    def current_user
      context[:current_user]
    end

    def form
      context[:form]
    end

    def model_css_class
      return "#{model.profile.klass.sub("_", "-")}" if model.is_a?(User)
      return "#{model.klass.sub("_","-")}" if model.is_a?(Profile) || model.is_a?(Alt)
      "#{model.user.profile.klass.sub("_", "-")}"
    end

    def current_user_css_class
      "#{current_user.profile.klass.sub("_", "-")}"
    end

    def profile_link user
      link_to user.username.humanize, show_profile_path(username: user.username), class: "#{model_css_class}"
    end
  end
end
