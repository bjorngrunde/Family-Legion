class Forum::Thread::Create < Trailblazer::Operation

  step Model(ForumThread, :new)
  step Contract::Build(constant: Forum::Thread::Contract::New)
  step Contract::Validate(key: :forum_thread)
  step :associations!
  step Contract::Persist()

  def associations!(options, params:, **)
    category = ForumCategory.find_by(slug: params[:category])
    options["model"].forum_category = category
    options["model"].forum_group = category.forum_group
    options["model"].user = options["current_user"]
  end
end
