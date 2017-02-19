class User < ApplicationRecord
	serialize :auth_meta_data

	#Associations
	has_one :profile
	
end
