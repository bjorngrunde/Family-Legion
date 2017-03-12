class Profile::Edit < Trailblazer::Operation

  step Model(Profile, :find_by)
  step Contract::Build(constant: Profile::Contract::Edit)
  
end