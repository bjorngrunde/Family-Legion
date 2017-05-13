class Event::New < Trailblazer::Operation

  step Model(Event, :new)
  step Contract::Build(constant: Event::Contract::New)
end
