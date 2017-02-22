module User::Contract
	class New < Reform::Form

		property 	:username
		property	:email
		property	:password, virtual: true
		property	:auth_meta_data

		validates :email, :password, :username, presence: true
		validates_uniqueness_of :email
		validates_uniqueness_of :username

		property :profile, populate_if_empty: Profile do
			property	:klass
			property	:server
			property	:first_name
			property	:last_name
			property	:thumbnail
			property	:avatar
			property	:spec
			property	:rank

			validates :klass, :server, :first_name, :last_name, presence: true
			validate :guild_master_exists?

			def guild_master_exists?
				return if rank != "guild_master"
				errors.add(:rank, "A user with rank Guild Master already exists") if Profile.find_by(rank: rank)
			end
		end
	end
end