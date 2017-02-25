class Setting::ChangePassword < Trailblazer::Operation

  step Model(User, :find_by)
  step Contract::Build(constant: Setting::Contract::ChangePassword)
  step Contract::Validate(key: :user)
  step :not_authorized!
  step :check_old_password!
  step :change_password!
  step Contract::Persist()

  def not_authorized!(options, **)
    options["model"].id == options["current_user"].id
  end

  def check_old_password!(options, **)
    options["auth"] = Tyrant::Authenticatable.new(options["contract.default"])
    options["auth"].digest?(options["contract.default"].old_password)
  end

  def change_password!(options, **)
    options["auth"].digest!(options["contract.default"].new_password)
    options["auth"].confirmed!
    options["auth"].sync
  end

end
