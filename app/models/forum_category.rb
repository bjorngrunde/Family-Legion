class ForumCategory < ApplicationRecord
  resourcify
  include Authority::Abilities

  belongs_to :forum_group
  has_many :forum_threads
  has_many :forum_comments

  self.authorizer_name = 'ForumAuthorizer'

  before_save :set_slug!

  def set_slug!
    self.slug = self.title.parameterize
  end
end
