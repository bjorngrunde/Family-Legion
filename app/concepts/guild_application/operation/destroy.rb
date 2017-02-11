class GuildApplication::Destroy < Trailblazer::Operation

  step  Model(GuildApplication, :find_by)
  step  :destroy!

  def destroy!(options, **)
    options["model"].destroy
  end

  def rollback(exception, options)
    options["x"] = exception.class
  end
end
