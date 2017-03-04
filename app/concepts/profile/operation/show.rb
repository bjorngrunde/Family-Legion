class Profile::Show < Trailblazer::Operation

  step :model!
  step Nested(:init_wow_api!)
  step :check_items_meta_data!
  step :save!

  def model!(options, **)
    options["model"] = User.find_by(username: options["params"]["username"])
  end

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def check_items_meta_data!(options, **)
    if options["model"].profile.profile_meta_data.nil?
      data = RBattlenet::Wow::Character.find(name: options["model"].username, realm: options["model"].profile.server, fields: ["items"])
      
      profile_meta_data = { created_at: DateTime.now, updated_at: DateTime.now}
      profile_meta_data.store(:items, data["items"])
      
      options["model"].profile.profile_meta_data = profile_meta_data
    end
  end

  def save!(options, **)
    options["model"].profile.save
  end

end