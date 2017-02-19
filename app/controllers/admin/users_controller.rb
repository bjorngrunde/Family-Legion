class Admin::UsersController < AdminController

	add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path
  add_breadcrumb I18n.t("breadcrumbs.users"), :admin_users_path, :only => %w(index show edit)
  add_breadcrumb I18n.t("breadcrumbs.show"), :admin_user_path, :only => %w(show edit)
  add_breadcrumb I18n.t("breadcrumbs.edit"), :edit_admin_guser_path, :only => %w(edit)
	
	def create_user_from_guild_application
		result = run User::CreateUserFromGuildApplication
		if result.success?
			return redirect_to admin_user_path(result["model"]), :positive => { :header => t(:user_created), :content => t(:you_created_user, result["model"].username) }
		end
	end

	def index
		result = run User::Index
		render cell(User::Cell::Table, result["model"])
	end

	def show
		result = run User::Show
		if result.success?
			return render cell(User::Cell::Show, result["model"])
		end
	end
	
end