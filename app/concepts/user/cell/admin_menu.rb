module User::Cell
  class AdminMenu < Familylegion::Cell::Master

    def edit_button
      link_to("<i class='edit icon'></i> #{t(:edit)}",  edit_admin_user_path(model), class: "tiny ui icon alliance button", data: { :tooltip => t(:edit_user), :position =>"bottom center"}).html_safe
    end

    def ban_button
      link_to("<i class='ban icon'></i> #{t(:ban)}", "#", class: "tiny ui alliance button", method: :post, data: { tooltip: t(:ban_user), position:"bottom left"})
    end

    def roles_button
      link_to("<i class='protect icon'></i> #{t(:roles)}", admin_user_roles_path(model.username), class: "tiny ui alliance button", data: { tooltip: t(:user_roles), position: "bottom right"})
    end
  end
end
