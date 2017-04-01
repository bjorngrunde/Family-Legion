class ForumThread < ApplicationRecord
  resourcify
  include Authority::Abilities

  belongs_to :forum_group
  belongs_to :forum_thread
  belongs_to :user
  has_many :forum_comments

  self.authorizer_name = 'ForumAuthorizer'

end
