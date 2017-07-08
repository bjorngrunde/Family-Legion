class Forum::Comment::Create < Trailblazer::Operation

  step Model(ForumComment, :new)
  step Policy::Pundit(ForumPolicy, :create_comment?)
  step Contract::Build(constant: Forum::Comment::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
  step :notify!
  success :get_number_of_pages!

  def notify!(options, **)
    return true if options["model"].forum_thread.user == options["model"].user
    Notification.create({
      user_id: options["current_user"].id,
      recipient_id: options["model"].forum_thread.user.id,
      action: "comment",
      notifiable: options["model"]
      })
  end

  #Could be improved later, need this to get the number of pages for the comments section, so we can link to the anchor of correct page
  def get_number_of_pages!(options, **)
    options["thread"] = ForumThread.find_by(id: options["model"].forum_thread.id)
    options["pages"] = options["thread"].forum_comments.page(1).per(12).total_pages
  end
end
