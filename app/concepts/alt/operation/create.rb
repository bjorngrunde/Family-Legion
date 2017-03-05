class Alt::Create < Trailblazer::Operation

  step Nested(:build!)
  step Contract::Validate(key: :alt)
  step Nested(:init_wow_api!)
  step Nested(:get_thumbnail!, input: ->(options, mutable_data:, runtime_data:, **)do
    { "name" => mutable_data["contract.default"].name,
      "realm" => mutable_data["contract.default"].server,
      "contract" => mutable_data["contract.default"]}
  end
  )
  step :add_thumbnail!
  step :add_user!
  step Contract::Persist()

  def build!(options, **)
    Alt::New
  end

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def get_thumbnail!(options, **)
    Wowapi::Thumbnail
  end

  def add_thumbnail!(options, **)
    options["model"].thumbnail = options["thumbnail"]
  end

  def add_user!(options, **)
    options["model"].user = options["current_user"]
  end
end