class Dungeon::New < Trailblazer::Operation

  step Model(Dungeon, :new)
  step Policy::Pundit(AdminPolicy, :create?)
  step Contract::Build(constant: Dungeon::Contract::New)

end
