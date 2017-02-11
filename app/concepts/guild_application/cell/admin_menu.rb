module GuildApplication::Cell
  class AdminMenu < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation

    def edit_button
      link_to("<i class='edit icon'></i> #{t(:edit)}",  edit_admin_guild_application_path(model), class: "tiny ui icon blue button", data: { :tooltip => t(:edit_application), :position =>"bottom left"}).html_safe
    end

    def delete_button
      link_to("<i class='erase icon'></i> #{t(:delete)}", admin_guild_application_path(model),  method: :delete, class: "tiny ui icon blue button", data: { tooltip: t(:delete_application), position:"bottom center", confirm: t(:alert_delete)}).html_safe
    end

    def create_user_button
      link_to("<i class='create user icon'></i> #{t(:create_user)}",  "#", class: "tiny ui icon green button", data: { :tooltip => t(:create_user_from), :position =>"bottom right"}).html_safe if model.status == "accepted"
    end
  end
end
