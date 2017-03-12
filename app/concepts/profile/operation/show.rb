class Profile::Show < Trailblazer::Operation

  step :model!
  step Nested(:init_wow_api!)
  step Nested(:check_items_meta_data!, input: ->(options, mutable_data:,**) do 
    { "username" => mutable_data["model"].username,
      "realm" => mutable_data["model"].profile.server,
      "meta_data" => mutable_data["model"].profile.profile_meta_data,
    } 
    end)
  step :save!

  def model!(options, params:,  **)
    options["model"] = User.find_by(username: params[:username])
  end

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def check_items_meta_data!(options, **)
    Wowapi::ProfileMetaData
  end

  def save!(options, **)
    return true unless options["meta_data"]
    options["model"].profile.update_attribute(:profile_meta_data, options["meta_data"])
  end
end