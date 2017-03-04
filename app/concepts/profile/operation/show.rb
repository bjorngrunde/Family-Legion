class Profile::Show < Trailblazer::Operation

  step :model!
  step Nested(:init_wow_api!)
  step Nested(:check_items_meta_data!, input: ->(options, mutable_data:,**) do 
    { "user" => mutable_data["model"] } 
    end)
  step :save!

  def model!(options, **)
    options["model"] = User.find_by(username: options["params"]["username"])
  end

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def check_items_meta_data!(options, **)
    Wowapi::ProfileMetaData
  end

  def save!(options, **)
    options["model"].profile.update_attributes(profile_meta_data: options["meta_data"]) unless options["meta_data"].empty?
    options["flash"] = t(:profile_has_been_updated) if options["model"].id == current_user.id && options["model"].profile.profile_meta_data_changed?
  end

end