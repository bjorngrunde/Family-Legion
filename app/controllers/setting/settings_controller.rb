class Setting::SettingsController < ApplicationController
  before_action :require_login
  before_action :not_authorized!

  def control_panel
    return render cell(Familylegion::Cell::Setting, nil, context: { cell_view: "Setting::Cell::ControlPanel", current_user: tyrant.current_user })
  end

  def change_password
    result = run Setting::New
    return render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Setting::Cell::ChangePassword", current_user: tyrant.current_user, form: result["contract.default"] }) if result.success?
  end

  def new_password
    result = run Setting::ChangePassword
    return redirect_to user_setting_control_panel_path(username: tyrant.current_user.username), :positive => { header: t(:oh_yeah), content: t(:password_changed)} if result.success?
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Setting::Cell::ChangePassword", current_user: tyrant.current_user, form: result["contract.default"] })
  end
end
