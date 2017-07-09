module GuildApplication::Cell
  class Index < Familylegion::Cell::Master

    property  :status
    property  :first_name
    property  :last_name
    property  :created_at

    private
      def status
        t(model.status.to_sym)
      end

      def full_name
        "#{model.first_name} #{model.last_name}".titleize
      end

      def created_at
        "#{time_ago_in_words(model.created_at)} ago".humanize
      end

      def edit_link
        link_to t(:show), admin_guild_application_path(model)
      end

      def color_class
        "#{model.status}"
      end
  end
end
