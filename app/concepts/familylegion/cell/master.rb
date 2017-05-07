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
      link_to user.username.humanize, show_profile_path(username: user.username), class: "#{user.profile.klass.sub('_', '-')}", data: { turbolinks: false }
    end

    def complete_user_link user
      "#{image_tag(user.profile.thumbnail, class:"ui avatar image")} #{profile_link(user)}"
    end

    def current_user_avatar_image
      image_tag(current_user.profile.thumbnail, class:"ui avatar image")
    end

    def updated_at
      "#{time_ago_in_words(model.updated_at)}".humanize
    end

    def created_at
      "#{time_ago_in_words(model.created_at)}".humanize
    end

    def is_owner?
      model.user == current_user
    end
  end
end
