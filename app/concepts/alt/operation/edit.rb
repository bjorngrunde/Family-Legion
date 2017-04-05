class Alt::Edit < Trailblazer::Operation

  step Model(Alt, :find_by)
  step Policy::Pundit(AltPolicy, :update?)
  step Contract::Build(constant: Alt::Contract::New)
end