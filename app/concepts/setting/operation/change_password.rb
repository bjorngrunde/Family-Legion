class Setting::ChangePassword < Trailblazer::Operation

  step Model(User, :find_by)
  step Policy::Pundit(UserPolicy, :settings?)
  step Contract::Build(constant: Setting::Contract::ChangePassword)
  step Contract::Validate(key: :user)
  step :not_authorized!
  step :check_old_password!
  failure :wrong_password!
  step :change_password!
  step Contract::Persist()

  def not_authorized!(options, **)
    options["model"].id == options["current_user"].id
  end

  def check_old_password!(options, **)
    Tyrant::Authenticatable.new(options["model"]).digest?(options["contract.default"].old_password)
  end

  def wrong_password!(options, **)
    options["contract.default"].errors.add(:old_password, :wrong_password)
  end

  def change_password!(options, **)
    auth = Tyrant::Authenticatable.new(options["contract.default"])
    auth.digest!(options["contract.default"].new_password)
    auth.confirmed!
    auth.sync
  end

end
