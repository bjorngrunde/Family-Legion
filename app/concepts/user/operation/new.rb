class User::New < Trailblazer::Operation

	step Model( User, :new )
  step Policy::Pundit(UserPolicy, :create?)
	step Contract::Build(constant: User::Contract::New)

end