class Wowapi::Thumbnail < Trailblazer::Operation
  #Required input is a valid character name (name:) and server (realm:) 
  #and a reform object with property :username(contract) so we can add errors in case of exception
  
  step Rescue( CharacterNotFoundError, handler: :rollback!){
    step :download_thumbnail!
  }
  
  def download_thumbnail!(options, name:, realm:, **)
    character = RBattlenet::Wow::Character.find(name: name, realm: realm)
    
    return raise CharacterNotFoundError, character.parsed_response["reason"] if character.parsed_response["status"] == "nok" || character["thumbnail"].nil?
    
    options["thumbnail"] = "http://render-eu.worldofwarcraft.com/character/#{character["thumbnail"]}"
    options["avatar"] = "http://render-eu.worldofwarcraft.com/character/#{character['thumbnail'].sub('avatar', 'profilemain')}"
  end

  def rollback!(exception, options,  **)
    if options["contract"]
      options["contract.default"] = options["contract"]
      options["contract.default"].errors.add(:base, exception.class.name.to_sym)
    else
      options["flash"] = t(:base_user_does_not_exist)
    end
  end
end