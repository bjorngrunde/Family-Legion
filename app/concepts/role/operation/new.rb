class Role::New < Trailblazer::Operation
  
  step :get_user!
  step :get_roles!
  step Contract::Build(constant: Role::Contract::New)
  
  def get_user!(options, params:, **)
    options["model"] = User.find_by(username: params[:username])
  end
  
  def get_roles!(options, **)
    options["roles"] = Role.all
  end
end