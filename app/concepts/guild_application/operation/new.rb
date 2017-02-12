class GuildApplication::New < Trailblazer::Operation

  step Model( GuildApplication, :new)
  step Contract::Build(constant: GuildApplication::Contract::Show)

end
