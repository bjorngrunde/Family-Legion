class GuildApplication::Update < Trailblazer::Operation

  step Nested(:build!)
  step Contract::Validate(key: :guild_application)
  step Contract::Persist()

  private
  def build!(options, **)
    GuildApplication::Edit
  end
end
