class Alt::Update < Trailblazer::Operation

  step Model(Alt, :find_by)
  step Contract::Build(constant: Alt::Contract::New)
  step Contract::Validate(key: :alt)
  step Nested(:init_wow_api!)
  step Nested(:get_thumbnail!, input: ->(options, mutable_data:, runtime_data:, **)do
    { "name" => mutable_data["contract.default"].username,
      "realm" => mutable_data["contract.default"].server,
      "contract" => mutable_data["contract.default"]}
  end
  )
  step :add_thumbnail!
  step Contract::Persist()

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def get_thumbnail!(options, **)
    Wowapi::Thumbnail
  end

  def add_thumbnail!(options, **)
    options["model"].thumbnail = options["thumbnail"]
  end
end