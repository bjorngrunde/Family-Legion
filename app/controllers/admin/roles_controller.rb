class Admin::RolesController < AdminController
  before_action :require_login
  
  add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path, :only => %w(show_roles)
  add_breadcrumb I18n.t("breadcrumbs.users"), :admin_users_path, :only => %w(show_roles)
  
  def show_roles
    result = run Role::New
    add_breadcrumb I18n.t("breadcrumbs.show", user: result["model"].username), admin_user_path(result["model"].id), :only => %w(show_roles)
    add_breadcrumb I18n.t("breadcrumbs.roles", :admin_user_roles_path)
    render cell(Role::Cell::New, result["model"], context: { form: result["contract.default"], current_user: current_user})
  end
  
  def add_role
    result = run Role::Add
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to admin_user_roles_path(result["model"].username), flashy(:positive, t(:oh_yeah), t(:role_added, role: params[:role_contract_new][:roles], user: result["model"].username)) if result.success?
    render cell(Role::Cell::New, result["model"], context: { form: result["contract.default"], current_user: current_user})
  end
  
  def remove_role
    result = run Role::Delete
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to admin_user_roles_path(result["model"].username), flashy(:positive, t(:oh_yeah), t(:role_removed)) if result.success?
  end
end