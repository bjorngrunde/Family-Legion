class ForumThread < ApplicationRecord
  resourcify
  include Authority::Abilities

  belongs_to :forum_group
  belongs_to :forum_category
  belongs_to :user
  has_many :forum_comments

  self.authorizer_name = 'ForumAuthorizer'

  before_save :set_slug!

  def set_slug!
    self.slug = self.title.parameterize
  end
end
