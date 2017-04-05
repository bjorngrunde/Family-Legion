module Role::Cell
  class New < Familylegion::Cell::Master
    
    def role_link name
      link_to "#{name.humanize} <i class='close icon'></i>", admin_remove_user_role_path(username: model.username, role: name.to_sym), method: :delete, class: "ui label", data: { tooltip: t(:click_to_remove_role), position: "top center"}
    end
  end
end