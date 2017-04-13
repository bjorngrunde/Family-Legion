class Forum::Thread::Copy < Trailblazer::Operation
  step Model(ForumThread, :new)
  step Contract::Build(constant: Forum::Thread::Contract::Move)
  step Contract::Validate()
  step :find_thread_to_copy!
  step :copy!
  step Contract::Persist()

  def find_copyable_thread!(options, params:, **)
    options["thread_to_copy"] = ForumThread.find_by(id: params[:id])
  end

  def copy!(options, **)
    twin = ForumThreadTwin.new(options["thread_to_copy"])
    twin.copy!
    twin.sync
  end
end
