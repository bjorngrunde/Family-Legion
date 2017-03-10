class  Alt::New < Trailblazer::Operation

  step Model(Alt, :new)
  step Contract::Build(constant: Alt::Contract::New)
end