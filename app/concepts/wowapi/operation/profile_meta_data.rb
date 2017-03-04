class Wowapi::ProfileMetaData < Trailblazer::Operation

  step :create_or_update_meta_data

  def create_or_update_meta_data(options, user:, **)
    if user.profile.profile_meta_data.nil? || user.profile.profile_meta_data[:updated_at] < 24.hours.ago
      
      data = RBattlenet::Wow::Character.find(name: user.username, realm: user.profile.server, fields: ["items","talents"])
      
      created_at = user.profile.profile_meta_data.nil? ? DateTime.now : user.profile.profile_meta_data[:created_at]

      profile_meta_data = { created_at: created_at, updated_at: DateTime.now}
      profile_meta_data.store(:items, data["items"])
      profile_meta_data.store(:talents, data["talents"])
      
      options["meta_data"] = profile_meta_data
    end
  end
end