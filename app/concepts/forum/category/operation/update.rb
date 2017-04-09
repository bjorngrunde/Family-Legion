class Forum::Category::Update < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
  step Contract::Build(constant: Forum::Category::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
  step :update_threads!
  step :update_comments!

  def update_threads!(options, **)
    options["model"].forum_threads.update_all(forum_group_id: options["model"].forum_group.id)
  end

  def update_comments!(options, **)
    options["model"].forum_comments.update_all(forum_group_id: options["model"].forum_group.id)
  end
end
