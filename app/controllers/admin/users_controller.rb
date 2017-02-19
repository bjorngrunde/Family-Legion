class Admin::UsersController < AdminController

	def create_user_from_guild_application
		result = run User::CreateUserFromGuildApplication
		if result.success?
			return redirect_to admin_user_path(result["model"]), :positive => { :header => t(:user_created), :content => t(:you_created_user, result["model"].username) }
		end
	end
	
end