class ForumGroup < ApplicationRecord
  resourcify
  include Authority::Abilities

  has_many :forum_categories
  has_many :forum_threads
  has_many :forum_comments

  self.authorizer_name = 'ForumAuthorizer'

  before_save :set_slug!

  def set_slug!
    self.slug = self.title.parameterize
  end
end
