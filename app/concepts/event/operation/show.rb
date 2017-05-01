class Event::Show < Trailblazer::Operation

  step Model(Event, :find_by)
end
