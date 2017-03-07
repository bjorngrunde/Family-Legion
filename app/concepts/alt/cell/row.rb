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
      link_to "<i class='trash large icon'></i>", user_setting_alt_path(id: model.id), method: :delete, data: { confirm: t(:alert_delete)}
    end

    def change_main_link
      link_to "<i class='exchange large icon'></i>", user_setting_change_main_path(id: model.id), method: :post, data: { confirm: t(:sure_to_change_main), tooltip: "#{t(:change_main_tooltip)}"}
    end

    def created_at
     "#{time_ago_in_words(model.created_at)} ago".humanize
    end
  end
end