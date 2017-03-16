class Profile::Edit < Trailblazer::Operation

  step Model(Profile, :find_by)
  step Policy::Pundit(ProfilePolicy, :update?)
  step Contract::Build(constant: Profile::Contract::Edit)
  
end