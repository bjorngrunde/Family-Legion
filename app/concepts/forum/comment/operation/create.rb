class Forum::Comment::Create < Trailblazer::Operation

  step Model(ForumComment, :new)
  step Policy::Pundit(ForumPolicy, :create_comment?)
  step Contract::Build(constant: Forum::Comment::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
  success :get_number_of_pages!


  #Could be improved later, need this to get the number of pages for the comments section, so we can link to the anchor of correct page
  def get_number_of_pages!(options, **)
    options["thread"] = ForumThread.find_by(id: options["model"].forum_thread.id)
    options["pages"] = options["thread"].forum_comments.page(1).per(12).num_pages
  end
end
