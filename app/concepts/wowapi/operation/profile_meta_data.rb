class Wowapi::ProfileMetaData < Trailblazer::Operation
  #Accepts a in-game character name(username:), their associated realm(realm:) profile_meta_data(meta_data:)
  #as well as a reform object (contract) for error collection

  step Rescue(CharacterNotFoundError, handler: :rollback!){
    step :create_or_update_meta_data
  }


  def create_or_update_meta_data(options, username:, realm: , meta_data:, **)
    #binding.pry
    if meta_data.nil? || meta_data[:updated_at] < 24.hours.ago

      data = RBattlenet::Wow::Character.find(name: username, realm: realm, fields: ["items","talents"])

      created_at = meta_data.nil? ? DateTime.now : meta_data[:created_at]

      profile_meta_data = { created_at: created_at, updated_at: DateTime.now}
      profile_meta_data.store(:items, data["items"])
      profile_meta_data.store(:talents, data["talents"])

      options["meta_data"] = profile_meta_data
    else
      true
    end
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
