class GuildApplication::Show < Trailblazer::Operation

  step Model(GuildApplication, :find_by)
  step Contract::Build( constant: GuildApplication::Contract::Show)
end
