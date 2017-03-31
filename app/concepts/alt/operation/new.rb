class  Alt::New < Trailblazer::Operation

  step Model(Alt, :new)
  step Policy::Pundit(AltPolicy, :create?)
  step Contract::Build(constant: Alt::Contract::New)
end