class Forum::Thread::Copy < Trailblazer::Operation

  step Model(ForumThread, :new)
  step Contract::Build(constant: Forum::Thread::Contract::Move)
  step Contract::Validate(key: :forum_thread)
  step :find_thread_to_copy!
  step :copy!
  step :modify!
  step Contract::Persist()

  def find_thread_to_copy!(options, params:, **)
    options["thread_to_copy"] = ForumThread.find_by(id: params[:id])
  end

  def copy!(options, **)
    options["model"].title = options["thread_to_copy"].title
    options["model"].body = options["thread_to_copy"].body
    options["model"].pinned = options["thread_to_copy"].pinned
    options["model"].user_id = options["thread_to_copy"].user_id
  end

  def modify!(options, **)
    twin = ForumThreadTwin.new(options["model"])
    twin.change_title!
    twin.change_body(options["current_user"])
    twin.sync
  end
end
