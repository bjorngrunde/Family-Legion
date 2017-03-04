class Alt::Create < Trailblazer::Operation

  step Nested(:build!)
  step Contract::Validate(key: :alt)
  step Nested(:init_wow_api!)
  step :add_thumbnail!
  step :add_user!
  step Contract::Persist()

  def build!(options, **)
    Alt::New
  end

  def init_wow_api!(options, **)
    Wowapi::Initialize
  end

  def add_thumbnail!(options, **)
    character = RBattlenet::Wow::Character.find(name: options["contract.default"].name, realm: options["contract.default"].server)
    options["model"].thumbnail = "http://render-eu.worldofwarcraft.com/character/#{character['thumbnail']}"
  end

  def add_user!(options, **)
    options["model"].user = options["current_user"]
  end
end