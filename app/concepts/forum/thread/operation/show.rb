class Forum::Thread::Show < Trailblazer::Operation

  step :build!

  def build!(options, params:, **)
    options["model"] = ForumThread.find_by(url: params[:url])
  end
end
