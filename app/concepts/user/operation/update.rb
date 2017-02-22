class User::Update < Trailblazer::Operation

  step Model(User, :find_by)
  step Contract::Build(constant: User::Contract::New)
  step Contract::Validate(key: :user)
  step Contract::Persist()
  
end