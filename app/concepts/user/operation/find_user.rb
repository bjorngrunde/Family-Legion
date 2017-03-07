class User::FindUser < Trailblazer::Operation
  step :find_user!

  def find_user!(options, **)
    options["model"] = User.find_by(username: options["params"]["username"])
  end
end