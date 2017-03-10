class Alt::Index < Trailblazer::Operation

  step :find_alts!

  def find_alts!(options, **)
    options["model"] = options["current_user"].alts.all
  end
end