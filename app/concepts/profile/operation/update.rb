class Profile::Update < Trailblazer::Operation

  step Nested(:model!)
  step Contract::Validate(key: :profile)
  step Nested(:init_wow_api!)
  step Nested(:get_thumbnail!, input: ->(options, mutable_data:,**) do 
    { "name" => mutable_data["contract.default"].user.username,
      "realm" => mutable_data["contract.default"].server,
      "contract" => mutable_data["contract.default"]
    }
  end)
  step :add_thumbnail!
  step :prepare_meta_data!
  step Nested(:get_meta_data!, input: ->(options, mutable_data:, **) do 
    { "username" => mutable_data["contract.default"].user.username,
      "realm" => mutable_data["contract.default"].server,
      "meta_data" => mutable_data["contract.default"].profile_meta_data,
      "contract" => mutable_data["contract.default"]}
  end)
  step Contract::Persist()

  def model!(options, **)
    Profile::Edit
  end

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def get_thumbnail!(options, **)
    Wowapi::Thumbnail
  end

  def add_thumbnail!(options, **)
    options["contract.default"].thumbnail = options["thumbnail"]
    options["contract.default"].avatar = options["avatar"]
  end

  def prepare_meta_data!(options, **)
    options["contract.default"].profile_meta_data[:updated_at] = 30.hours.ago
  end

  def get_meta_data!(options, **)
    Wowapi::ProfileMetaData
  end

  def add_meta_data!(options, **)
    options["contract.default"].profile_meta_data = options["meta_data"]
  end
end