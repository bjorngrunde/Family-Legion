class Forum::Thread::Show < Trailblazer::Operation

  step :build!
  step :comments!

  def build!(options, params:, **)
    options["model"] = ForumThread.find_by(slug: params[:thread])
  end

  def comments!(options, params:, **)
    options["comments"] = options["model"].forum_comments.order(:updated_at).page(params[:page]).per(12)
  end
end
