class Admin::UsersController < AdminController
	
	before_action :require_login
	
	add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path
  add_breadcrumb I18n.t("breadcrumbs.users"), :admin_users_path, :only => %w(index show edit new)
  add_breadcrumb I18n.t("breadcrumbs.new"), :new_admin_user_path, :only => %w(new)
  
	def create_user_from_guild_application
		result = run User::CreateUserFromGuildApplication
		return policy_breach! if result["result.policy.default"].failure?
		return redirect_to admin_user_path(result["model"]), :positive => { :header => t(:oh_yeah), :content => t(:user_created, name: result["model"].username) } if result.success?
		render cell(User::Cell::New, result["model"], context: { form: result["contract.default"]})
	end

	def index
		result = run User::Index
		render cell(User::Cell::Table, result["model"])
	end

	def new
		result = run User::New
		return policy_breach! if result["result.policy.default"].failure?
		return render cell(User::Cell::New, result["model"], context: { form: result["contract.default"]}) if result.success?
		redirect_to dashboard_path
	end

	def show
		result = run User::Show
		add_breadcrumb I18n.t("breadcrumbs.show", user: result["model"].username), :admin_user_path, :only => %w(show edit)
		render cell(User::Cell::Show, result["model"])
	end

	def edit
		result = run User::Edit
		return policy_breach! if result["result.policy.default"].failure?
		add_breadcrumb I18n.t("breadcrumbs.show", user: result["model"].username), :admin_user_path
		add_breadcrumb I18n.t("breadcrumbs.edit"), :edit_admin_user_path
		return render cell(User::Cell::Edit, result["model"], context: { form: result["contract.default"]}) if result.success?
		redirect_to dashboard_path
	end
	
	def update
		result = run User::Update
		return policy_breach! if result["result.policy.default"].failure?
		return redirect_to admin_user_path(result["model"]), :positive => { :header => "", :content => t(:user_updated, name: result["model"].username.humanize)} if result.success?
		render cell(User::Cell::Edit, result["model"], context: { form: result["contract.default"]})
	end
end