module GuildApplication::Contract
  class Create < Reform::Form
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

    property  :screenshot, virtual: true
    processable_writer :image
    property  :image_meta_data

    validates :screenshot, file_size: { less_than: 2.megabytes }, file_content_type: { allow: ['image/jpeg', 'image/png'] }
    validates :email, :username, :server, :first_name, :last_name, presence: true
    validates_uniqueness_of :email
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates_uniqueness_of :username
  end
end
