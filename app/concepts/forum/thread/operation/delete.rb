class Forum::Thread::Delete < Trailblazer::Operation

  step Model(ForumThread, :find_by)
  step :delete!

  def delete!(options, **)
    options["model"].destroy
  end
end
