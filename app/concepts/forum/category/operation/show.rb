class Forum::Category::Show < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :read?)
  step Contract::Build(constant: Forum::Category::Contract::New)
  step :get_threads!

  def get_threads!(options, params:, **)
    options["threads"] = options["model"].forum_threads.order(:updated_at).page(params[:page]).per(12)
  end
end
