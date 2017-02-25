class Setting::New < Trailblazer::Operation

  step Model(User, :find_by)
  step Contract::Build(constant: User::Contract::New)
  step :check_user!

  def check_user!(options, **)
    options["model"].id == options["current_user"].id
  end
  
end