class Forum::Thread::Create < Trailblazer::Operation

  step Model(ForumThread, :new)
  step Contract::Build(constant: Forum::Thread::Contract::New)
  step Contract::Validate(key: :forum_thread)
  step :associations!
  step :friendly_url!
  step Contract::Persist()

  def associations!(options, params:, **)
    category = ForumCategory.find_by(id: params[:forum_category_id])
    options["model"].forum_category = category
    options["model"].forum_group = category.forum_group
    options["model"].user = options["current_user"]
  end

  def friendly_url!(options, **)
    options["model"].url = options["contract.default"].title.gsub(' ', '-')
  end
end
