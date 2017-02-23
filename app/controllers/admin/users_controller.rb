class Admin::UsersController < AdminController

	add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path
  add_breadcrumb I18n.t("breadcrumbs.users"), :admin_users_path, :only => %w(index show edit new)
  add_breadcrumb I18n.t("breadcrumbs.show"), :admin_user_path, :only => %w(show edit)
  add_breadcrumb I18n.t("breadcrumbs.new"), :new_admin_user_path, :only => %w(new)
  add_breadcrumb I18n.t("breadcrumbs.edit"), :edit_admin_user_path, :only => %w(edit)
	
	def create_user_from_guild_application
		result = run User::CreateUserFromGuildApplication
		if result.success?
			return redirect_to admin_user_path(result["model"]), :positive => { :header => t(:oh_yeah), :content => t(:user_created, name: result["model"].username) }
		end
		render cell(User::Cell::New, result["model"], context: { form: result["contract.user"]})
	end

	def index
		result = run User::Index
		render cell(User::Cell::Table, result["model"])
	end

	def new
		result = run User::New
		render cell(User::Cell::New, result["model"], context: { form: result["contract.user"]})
	end

	def show
		result = run User::Show
		if result.success?
			return render cell(User::Cell::Show, result["model"])
		end
	end

	def edit
		result = run User::Edit
		render cell(User::Cell::Edit, result["model"], context: { form: result["contract.default"]})
	end
	
	def update
		result = run User::Update
		if result.success?
			return redirect_to admin_user_path(result["model"]), :positive => { :header => "", :content => t(:user_updated, name: result["model"].username.humanize)}
		end
		redirect_to edit_admin_user_path(result["model"])
	end
end