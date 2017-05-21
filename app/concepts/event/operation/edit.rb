class Event::Edit < Trailblazer::Operation

  step Model(Event, :find_by)
  step Policy::Pundit(EventPolicy, :update?)
  step Contract::Build(constant: Event::Contract::New)
end