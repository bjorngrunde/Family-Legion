class ForumCategory < ApplicationRecord
  resourcify
  include Authority::Abilities

  belongs_to :forum_group
  has_many :forum_threads
  has_many :forum_comments

  self.authorizer_name = 'ForumAuthorizer'
end
