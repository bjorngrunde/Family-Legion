class Setting::New < Trailblazer::Operation

  step Model(User, :find_by)
  step Contract::Build(constant: User::Contract::New)
  step Policy::Pundit(UserPolicy, :settings?)
  
end