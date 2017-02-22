class User::Index < Trailblazer::Operation

	step :all_users!

	def all_users!(options, **)
		options["model"] = User.all
	end
end