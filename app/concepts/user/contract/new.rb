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

			validates :klass, :server, :first_name, :last_name, presence: true
		end
	end
end