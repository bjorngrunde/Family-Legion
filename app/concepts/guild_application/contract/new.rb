module GuildApplication::Contract
  class New < Reform::Form
    extend Paperdragon::Model::Writer

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
    property  :screenshot
  end
end
