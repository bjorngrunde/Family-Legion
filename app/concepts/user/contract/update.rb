module User::Contract
  class Update < Reform::Form

    property  :username
    property  :email

    validates :email, :username, presence: true
    validates_uniqueness_of :email
    validates_uniqueness_of :username

    property :profile, populate_if_empty: Profile do
      property  :klass
      property  :server
      property  :first_name
      property  :last_name
      property  :thumbnail
      property  :avatar
      property  :spec
      property  :rank
      property  :phone

      validates :klass, :server, :first_name, :last_name, presence: true
      validate :guild_master_exists?

      def guild_master_exists?
        profile = Profile.find(id)
        return if rank != "guild_master"
        return if profile.rank == "guild_master"
        errors.add(:rank, "A user with rank Guild Master already exists")
      end
    end
  end
end