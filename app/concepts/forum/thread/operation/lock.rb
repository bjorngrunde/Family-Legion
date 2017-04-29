class Forum::Thread::Lock < Trailblazer::Operation

  step Model(ForumThread, :find_by)
  step :toggle_lock!

  def toggle_lock!(options, **)
    options["model"].is_locked = options["model"].is_locked ? false : true
    options["model"].save
  end
end
