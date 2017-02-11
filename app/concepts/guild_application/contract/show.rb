module GuildApplication::Contract
  class Show < Reform::Form

    property  :first_name
    property  :last_name
    property  :email
    property  :username
    property  :armory
    property  :klass
    property  :server
    property  :spec
    property  :played
    property  :klass_played
    property  :bio
    property  :raid_experience
    property  :reason
    property  :old_guild
    property  :progress_raid
    property  :attendance
    property  :other
    property  :status
    property  :image_meta_data
  end
end
