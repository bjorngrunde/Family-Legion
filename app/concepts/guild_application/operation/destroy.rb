class GuildApplication::Destroy < Trailblazer::Operation

  step  Model(GuildApplication, :find_by)
  step  :destroy!

  def destroy!(options, **)
    options["model"].destroy
  end
end
