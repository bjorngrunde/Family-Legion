class  Alt::New < Trailblazer::Operation

  step Model(Alt, :new)
  step Policy::Pundit(UserPolicy, :settings?)
  step Contract::Build(constant: Alt::Contract::New)
end