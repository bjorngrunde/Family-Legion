class Role::Delete < Trailblazer::Operation
  
  step :get_user!
  step Policy::Pundit(UserPolicy, :editable?)
  step Policy::Pundit(UserPolicy, :deletable?)
  step :delete_role!
  
  def get_user!(options, params:, **)
    options["model"] = User.find_by(username: params[:username])
  end
  
  def delete_role!(options, params:, **)
    options["model"].remove_role params[:role]
  end
end