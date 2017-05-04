class Forum::Thread::Pin < Trailblazer::Operation
  step Model(ForumThread, :find_by)
  step :toggle_pin!

  def toggle_pin!(options, **)
    options["model"].pinned = options["model"].pinned ? false : true
    options["model"].save
  end
end
