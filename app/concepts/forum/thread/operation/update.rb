class Forum::Thread::Update < Trailblazer::Operation
  step Model(ForumThread, :find_by)
  step Policy::Pundit(ForumPolicy, :update_thread?)
  step Contract::Build(constant: Forum::Thread::Contract::New)
  step Contract::Validate(key: :forum_thread)
  step Contract::Persist()
end
