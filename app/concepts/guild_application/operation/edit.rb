class GuildApplication::Edit < Trailblazer::Operation
  step Model( GuildApplication, :find_by)
  step Contract::Build( constant: GuildApplication::Contract::Create)
end
