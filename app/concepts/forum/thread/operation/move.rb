class Forum::Thread::Move < Trailblazer::Operation

  step Model(ForumThread, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
  step Contract::Build(constant: Forum::Thread::Contract::Move)
  step Contract::Validate(key: :forum_thread)
  step Contract::Persist()
  step :update_comments!

  def update_comments!(options, **)
    options["model"].forum_comments.update_all(forum_group_id: options["model"].forum_group_id, forum_category_id: options["model"].forum_category_id)
  end
end
