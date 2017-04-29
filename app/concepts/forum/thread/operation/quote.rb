class Forum::Thread::Quote < Trailblazer::Operation

  step Model(ForumThread, :find_by)
end
