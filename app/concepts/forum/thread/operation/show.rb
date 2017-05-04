class Forum::Thread::Show < Trailblazer::Operation

  step :build!
  step :comments!
  step :add_views!

  def build!(options, params:, **)
    options["model"] = ForumThread.find_by(slug: params[:thread])
  end

  def comments!(options, params:, **)
    options["comments"] = options["model"].forum_comments.order(:updated_at).page(params[:page]).per(12)
  end

  def add_views!(options, **)
    return true if options["model"].views.find_by(user_id: options["current_user"].id)
    options["model"].views.create({user_id: options["current_user"].id })
  end
end
