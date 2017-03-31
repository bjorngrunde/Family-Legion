class ForumGroup < ApplicationRecord
  rolify
  include Authority::Abilities

  has_many :forum_categories
  has_many :forum_threads
  has_many :forum_comments
  belongs_to :user
end
