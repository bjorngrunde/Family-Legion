class Dungeon::Edit < Trailblazer::Operation

  step Model(Dungeon, :find_by)
  step Policy::Pundit(AdminPolicy, :update?)
  step Contract::Build(constant: Dungeon::Contract::New )
end
