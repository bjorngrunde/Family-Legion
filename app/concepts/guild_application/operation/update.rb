class GuildApplication::Update < Trailblazer::Operation

  step Model( GuildApplication, :find_by )
  step Contract::Build(constant: GuildApplication::Contract::Update)
  step Contract::Validate(key: :guild_application)
  step Contract::Persist(method: :sync)
end
