class ForumAuthorizer < ApplicationAuthorizer

  def self.creatable_by?(user)
    user.has_role? :moderator
  end
end
