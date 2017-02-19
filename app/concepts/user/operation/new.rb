class User::New < Trailblazer::Operation

	step Model( User, :new )
	step Contract::Build( name: "user", constant: User::Contract::New)

end