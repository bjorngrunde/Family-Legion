module GuildApplication::Cell
  class Index < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper

    property  :status
    property  :first_name
    property  :last_name
    property  :created_at

    private
      def status
        t(model.status.to_sym)
      end

      def full_name
        "#{model.first_name.capitalize} #{model.last_name.capitalize}"
      end

      def created_at
        "#{time_ago_in_words(model.created_at)} ago"
      end

      def edit_link
        link_to t(:show), admin_guild_application_path(model)
      end
  end
end
