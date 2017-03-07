class Alt::Edit < Trailblazer::Operation

  step Model(Alt, :find_by)
  step Contract::Build(constant: Alt::Contract::New)
end