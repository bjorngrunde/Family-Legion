class Event::Delete < Trailblazer::Operation

  step Model(Event, :find_by)
  step :delete!

  def delete!(options, **)
    options["model"].destroy
  end
end
