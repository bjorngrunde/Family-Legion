module Alt::Cell
  class Row < Familylegion::Cell::Master
    property  :name
    property  :server
    property  :klass
    property  :thumbnail

    def edit_link
      link_to "<i class='edit large icon'></i>", edit_user_setting_alt_path(id: model.id)
    end

    def destroy_link
      link_to "<i class='trash large icon'></i>", user_setting_alt_path(model), method: :delete, data: { confirm: t(:alert_delete)}
    end

    def created_at
     "#{time_ago_in_words(model.created_at)} ago".humanize
    end
  end
end