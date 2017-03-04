class User < ApplicationRecord
	serialize :auth_meta_data

	#Associations
	has_one :profile, dependent: :destroy
  has_many :alts, dependent: :destroy
	
end
