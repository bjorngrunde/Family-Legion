class Alt::ChangeMainCharacter < Trailblazer::Operation
  #Most steps can be move to a twin/twins
  step Model(Alt, :find_by)
  step :find_user!
  step :set_user!
  step :set_alt!
  step Nested(:init_wowapi!)
  step Nested(:update_meta_data!, input: ->(options, mutable_data:, **)do
    { "username" => mutable_data["user"].username,
      "realm" => mutable_data["user"].profile.server,
      "meta_data" => mutable_data["user"].profile.profile_meta_data
    }
  end)
  step :set_meta_data!
  step :save_user!
  step :save_alt!

  def find_user!(options, **)
    options["user"] = User.find_by(username: options["params"]["username"])
  end

  def set_user!(options, **)
    options["user"].username = options["model"].username
    options["user"].profile.klass = options["model"].klass
    options["user"].profile.server = options["model"].server
    options["user"].profile.thumbnail = options["model"].thumbnail
    options["user"].profile.avatar = options["model"].thumbnail.sub('avatar', 'profilemain')
    options["user"].profile.profile_meta_data[:updated_at] = 30.hours.ago
  end

  def set_alt!(options, **)
    options["model"].username = options["current_user"].username
    options["model"].server = options["current_user"].profile.server
    options["model"].klass = options["current_user"].profile.klass
    options["model"].thumbnail = options["current_user"].profile.thumbnail
  end

  def init_wowapi!(options, **)
    Wowapi::Initialize
  end

  def update_meta_data!(options, **)
    Wowapi::ProfileMetaData
  end

  def set_meta_data!(options, **)
    options["user"].profile.profile_meta_data = options["meta_data"]
  end

  def save_user!(options, **)
    options["user"].profile.save
    options["user"].save
  end

  def save_alt!(options, **)
    options["model"].save
  end
end