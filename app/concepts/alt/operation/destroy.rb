class Alt::Destroy < Trailblazer::Operation

  step Model(Alt, :find_by)
  step Policy::Pundit(AltPolicy, :delete?)
  step :delete_alt!

  def delete_alt!(options, **)
    options["model"].destroy
  end

end