class Forum::Thread::Edit < Trailblazer::Operation
  step Model(ForumThread, :find_by)
  step Policy::Pundit(ForumPolicy, :update_thread?)
  step Contract::Build(constant: Forum::Thread::Contract::New)
end
