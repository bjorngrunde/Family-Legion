class Event::Index < Trailblazer::Operation

  step :find_all!

  def find_all!(options, **)
    options["model"] = Event.today_and_forward
  end
end
