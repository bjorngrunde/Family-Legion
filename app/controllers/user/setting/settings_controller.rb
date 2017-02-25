class User::Setting::SettingsController < ApplicationController
  before_filter :require_login

  def control_panel
    result = run Setting::New
    if result.success?
      return render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "ControlPanel", current_user: tyrant.current_user })
    end
    not_authorized!
  end

  def change_password
    result = run Setting::New
    if result.success?
      return render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "ChangePassword", current_user: tyrant.current_user, form: result["contract.default"] })
    end
    not_authorized!
  end

  def new_password
    result = run Setting::ChangePassword
    if result.success?
      return redirect_to user_setting_control_panel_path(id: tyrant.current_user), :positive => { header: t(:oh_yeah), content: t(:password_changed)}
    end
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "ChangePassword", current_user: tyrant.current_user, form: result["contract.default"] })
  end

  private
  def not_authorized!
    redirect_to dashboard_path, :warning => { :header => t(:oh_dear), content: t(:not_authorized)}
  end
end
