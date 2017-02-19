class User::CreateUserFromGuildApplication < Trailblazer::Operation

	# Operations used:
	# User::New
	# Wowapi::Thumbnail
	# Mail::Welcome

	# Twins used:
	# Tyrant::Authenticatable


	step 	Nested(:build!)
	step 	:generate_password!
	step	Contract::Validate(name: "user")
	step 	Nested(:initialize_wowapi!)
	step	:generate_thumbnail!
	step	:create!
	step 	Contract::Persist(name: "user")
	#success	:send_email!

	def build!(options, **)
		User::New
	end

	def generate_password!(options, **)
		options["contract.user"].password = SecureRandom.hex 12
	end

	def initialize_wowapi!(options, **)
		Wowapi::Initialize
	end

	def generate_thumbnail!(options, **)
		character = RBattlenet::Wow::Character.find(name: "bubbleoncd", realm: "grim batol")
		options["contract.user"].profile.thumbnail = "http://eu.battle.net/static-render/eu/#{character['thumbnail']}"
	end

	def create!(options, **)
		auth = Tyrant::Authenticatable.new(options["contract.user"])
		auth.digest!(options["contract.user"].password)
		auth.confirmed!
		auth.sync
	end

	#def send_email!(options, **)
		#Mail::Welcome
	#end
end