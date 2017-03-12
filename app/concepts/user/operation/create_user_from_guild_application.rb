class User::CreateUserFromGuildApplication < Trailblazer::Operation

	step 	Nested(:build!)
	step 	:generate_password!
	step	Contract::Validate(key: :user)
	step 	Nested(:initialize_wowapi!)
	step	Nested(:download_thumbnail!, input: ->(options, mutable_data:, runtime_data:, **)do
		{ "name" => mutable_data["contract.default"].username,
			"realm" => mutable_data["contract.default"].profile.server,
			"contract" => mutable_data["contract.default"] }
	end 
	)
	step 	:add_thumbnail!
	step Nested(:update_meta_data!, input: ->(options, mutable_data: , runtime_data:, **)do
    { "username" => mutable_data["contract.default"].username,
    	"realm" => mutable_data["contract.default"].profile.server,
    	"meta_data" => mutable_data["contract.default"].profile.profile_meta_data,
    	"contract" => mutable_data["contract.default"]}
  end)
  step  :add_meta_data!
	step	:create!
	step 	Contract::Persist()
  success	:send_email!


	def build!(options, **)
		User::New
	end

	def generate_password!(options, **)
		options["generated_password"] = SecureRandom.hex(6)
		options["contract.default"].password = options["generated_password"]
	end

	def initialize_wowapi!(options, **)
		Wowapi::Initialize
	end

	def download_thumbnail!(options, **)
		Wowapi::Thumbnail
	end

	def add_thumbnail!(options, **)
		options["contract.default"].profile.thumbnail = options["thumbnail"]
		options["contract.default"].profile.avatar = options["avatar"]
	end

	def update_meta_data!(options, **)
		Wowapi::ProfileMetaData
	end

	def add_meta_data!(options, **)
		options["contract.default"].profile.profile_meta_data = options["meta_data"]
	end

	def create!(options, **)
		auth = Tyrant::Authenticatable.new(options["contract.default"])
		auth.digest!(options["contract.default"].password)
		auth.confirmed!
		auth.sync
	end

	def send_email!(options, **)
		UserMailer.welcome(options).deliver_now
	end
end