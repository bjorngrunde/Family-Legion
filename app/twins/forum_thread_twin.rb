class ForumThreadTwin < Disposable::Twin
  feature Sync

  property  :title
  property  :body
  property  :slug
  property  :pinned
  property  :user_id

  def copy!
    self.title = "#{self.title}-copied"
    self.slug = "#{self.title.parameterize}-copied"
  end
end
