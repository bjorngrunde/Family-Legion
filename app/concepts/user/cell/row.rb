module User::Cell
  class Row < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper

    property  :username
    property  :email
    property  :created_at

    private
      def full_username
        username = model.username.humanize
        "<span class='#{model.profile.klass}'>#{username}</span>".html_safe
      end

      def created_at
        "#{time_ago_in_words(model.created_at)} ago".humanize
      end

      def edit_link
        link_to t(:show), admin_user_path(model)
      end
  end
end
