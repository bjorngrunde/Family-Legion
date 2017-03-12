class User::Index < Trailblazer::Operation

	step :all_users!

	def all_users!(options, params:, **)
		return options["model"] = User.order(:username).page(params[:page]).per(15) unless params[:term]
    options["model"] = User.where("username LIKE ?", "%#{params[:term]}%").page(params[:page])
	end
end