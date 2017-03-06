class User::Setting::SettingsController < ApplicationController
  before_action :require_login

  def control_panel
    result = run Setting::New
    return render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Setting::Cell::ControlPanel", current_user: tyrant.current_user }) if result.success?
    not_authorized! if result["result.policy.default"].failure?
  end

  def change_password
    result = run Setting::New
    return render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Setting::Cell::ChangePassword", current_user: tyrant.current_user, form: result["contract.default"] }) if result.success?
    not_authorized! if result["result.policy.default"].failure?
  end

  def new_password
    result = run Setting::ChangePassword
    return redirect_to user_setting_control_panel_path(id: tyrant.current_user), :positive => { header: t(:oh_yeah), content: t(:password_changed)} if result.success?

    not_authorized! if result["result.policy.default"].failure?
    
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Setting::Cell::ChangePassword", current_user: tyrant.current_user, form: result["contract.default"] })
  end
end
