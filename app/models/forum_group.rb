class ForumGroup < ApplicationRecord
  resourcify
  include Authority::Abilities

  has_many :forum_categories
  has_many :forum_threads
  has_many :forum_comments

  self.authorizer_name = 'ForumAuthorizer'
end
