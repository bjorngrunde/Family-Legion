class ForumThreadTwin < Disposable::Twin
  feature Sync

  property  :title
  property  :body

  def change_title!
    self.title = "#{self.title} COPIED"
  end

  def change_body user
    body << "<br/> <small>Copied by <span class='#{user.profile.klass.gsub('_','-')}'>#{user.username.humanize}</span></small>"
  end
end
