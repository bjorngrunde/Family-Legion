class Setting::New < Trailblazer::Operation

  step Nested(:find_user!)
  step Contract::Build(constant: User::Contract::New)
  
  def find_user!(options, **)
    User::FindUser
  end
end