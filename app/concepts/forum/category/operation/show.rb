class Forum::Category::Show < Trailblazer::Operation

  step :model!
  step Policy::Pundit(ForumPolicy, :read?)
  step Contract::Build(constant: Forum::Category::Contract::New)
  step :get_threads!

  def get_threads!(options, params:, **)
    options["threads"] = options["model"].forum_threads.order(pinned: :desc, updated_at: :desc).page(params[:page]).per(12)
  end

  def model!(options, params:, **)
    options["model"] = ForumCategory.find_by(slug: params[:category])
  end
end
