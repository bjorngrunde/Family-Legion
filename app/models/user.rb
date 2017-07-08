class User < ApplicationRecord
  rolify
	include Authority::UserAbilities
  include Authority::Abilities

  serialize :auth_meta_data

	#Associations
	has_one :profile, dependent: :destroy
  has_many :alts, dependent: :destroy
  has_many :forum_threads
  has_many :forum_comments
  has_many :image_managers
  has_many :forum_views
  has_many :events
  has_many :invites
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id

  self.authorizer_name = 'AdminAuthorizer'

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:newbie) if self.roles.blank?
  end

end
