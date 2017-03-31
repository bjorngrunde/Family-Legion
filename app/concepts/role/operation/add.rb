class Role::Add < Trailblazer::Operation
    
  step :get_user!
  step Policy::Pundit(UserPolicy, :editable?)
  step Contract::Build(constant: Role::Contract::Add)
  step Contract::Validate(key: :role_contract_new)
  step :add_role!
  
  def get_user!(options, params:, **)
    options["model"] = User.find_by(username: params[:username])
  end
  
  def add_role!(options, params:, **)
    options["model"].add_role(params[:role_contract_new][:roles].to_sym)
  end
end