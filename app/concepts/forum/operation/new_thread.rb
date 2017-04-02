class Forum::NewThread < Trailblazer::Operation

  step Model(ForumThread, :new)
  step Contract::Build(constant: Forum::Contract::CreateThread)
  step :forum_category!

  def forum_category!(options, params:, **)
    options["category_id"] = params[:forum_category_id]
  end
end
