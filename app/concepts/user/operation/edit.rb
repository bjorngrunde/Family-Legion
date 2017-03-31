class User::Edit < Trailblazer::Operation

  step Model(User, :find_by)
  step Policy::Pundit(UserPolicy, :update?)
  step Contract::Build(constant: User::Contract::New)

end