class User::Index < Trailblazer::Operation

	step :all_users!

	def all_users!(options, **)
		return options["model"] = User.order(:username).page(options["params"]["page"]).per(15) unless options["params"]["term"]
    options["model"] = User.where("username LIKE ?", "%#{options["params"]["term"]}%").page(options["params"]["page"])
	end
end