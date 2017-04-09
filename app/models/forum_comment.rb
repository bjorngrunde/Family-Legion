class ForumComment < ApplicationRecord
  resourcify
  include Authority::Abilities

  belongs_to :forum_group
  belongs_to :forum_category
  belongs_to :forum_thread
  belongs_to :user

  self.authorizer_name = 'ForumAuthorizer'
end
