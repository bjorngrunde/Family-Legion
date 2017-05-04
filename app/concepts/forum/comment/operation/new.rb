class Forum::Comment::New < Trailblazer::Operation

  step Model(ForumComment, :new)
  step Policy::Pundit(ForumPolicy, :create_comment?)
  step Contract::Build(constant: Forum::Comment::Contract::New)
  step :get_thread!

  def get_thread!(options, params:, **)
    options["thread"] = ForumThread.find_by(slug: params[:thread])
  end
end
