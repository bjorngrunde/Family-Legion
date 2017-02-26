class User::CreateUserFromGuildApplication < Trailblazer::Operation

	step 	Nested(:build!)
	step 	:generate_password!
	step	Contract::Validate(name: "user", key: :user)
	step 	Nested(:initialize_wowapi!)
	step	:generate_thumbnail!
	step	:create!
	step 	Contract::Persist(name: "user")
  success	:send_email!

	def build!(options, **)
		User::New
	end

	def generate_password!(options, **)
		options["generated_password"] = SecureRandom.hex(6)
		options["contract.user"].password = options["generated_password"]
	end

	def initialize_wowapi!(options, **)
		Wowapi::Initialize
	end

	def generate_thumbnail!(options, **)
		character = RBattlenet::Wow::Character.find(name: options["contract.user"].username, realm: options["contract.user"].profile.server)
		options["contract.user"].profile.thumbnail = "http://render-eu.worldofwarcraft.com/character/#{character['thumbnail']}"
		options["contract.user"].profile.avatar = "http://render-eu.worldofwarcraft.com/character/#{character['thumbnail'].sub('avatar', 'profilemain')}"
	end

	def create!(options, **)
		auth = Tyrant::Authenticatable.new(options["contract.user"])
		auth.digest!(options["contract.user"].password)
		auth.confirmed!
		auth.sync
	end

	def send_email!(options, **)
		UserMailer.welcome(options).deliver_now
	end
end