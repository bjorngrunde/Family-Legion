module GuildApplication::Cell
  class AdminMenu < Familylegion::Cell::Master

    def decline_button
      link_to("<i class=' thumbs outline down icon'></i> #{t(:reject)}", admin_guild_application_toggle_status_path(status: :declined, id: model.id), class: "tiny ui alliance button", method: :post, data: { tooltip: t(:reject_application), position:"bottom left"}) if model.status == "pending" || model.status == "accepted"
    end

    def accept_button
      link_to("<i class=' thumbs outline up icon'></i> #{t(:approve)}", admin_guild_application_toggle_status_path(status: :accepted, id: model.id), class: "tiny ui alliance button", method: :post, data: { tooltip: t(:accept_application), position:"bottom center"}) if model.status == "pending" || model.status == "declined"
    end

    def edit_button
      link_to("<i class='edit icon'></i> #{t(:edit)}",  edit_admin_guild_application_path(model), class: "tiny ui icon alliance button", data: { :tooltip => t(:edit_application), :position =>"bottom center"}).html_safe
    end

    def delete_button
      link_to("<i class='erase icon'></i> #{t(:delete)}", admin_guild_application_path(model),  method: :delete, class: "tiny ui icon alliance button", data: { tooltip: t(:delete_application), position:"bottom right", confirm: t(:alert_delete)}).html_safe
    end

    def create_user_button
      link_to("<i class='create user icon'></i> #{t(:create_user)}",  admin_create_user_from_guild_application_path(user: { username: model.username, email: model.email, profile: { klass: model.klass, server: model.server, first_name: model.first_name, last_name: model.last_name, spec: model.spec}}), class: "tiny ui icon alliance button", method: :post,  data: { :tooltip => t(:create_user_from), :position =>"bottom right"}).html_safe if model.status == "accepted"
    end

  end
end
