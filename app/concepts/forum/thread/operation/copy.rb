class Forum::Thread::Copy < Trailblazer::Operation

  module ERRORS
    TWIN_SYNC_ERROR         = :twin_sync_error
    ASSIGN_ATTRIBUTES_ERROR = :assign_attributes_error
    NOT_FOUND_ERROR         = :not_found
  end

  step Model(ForumThread, :new)
  step Contract::Build(constant: Forum::Thread::Contract::Move)
  step Contract::Validate(key: :forum_thread)
  step :find_thread_to_copy!
  step :copy!
  success :modify!
  step Contract::Persist()
  failure :errors


  def find_thread_to_copy!(options, params:, **)
    options["thread_to_copy"] = ForumThread.find_by(id: params[:id])
  end

  def copy!(options, **)
    options["model"] = options["thread_to_copy"].dup
    options["model"].attributes = { forum_category_id: nil, forum_group_id: nil, forum_comments_count: 0}
  end

  def modify!(options, **)
    twin = ForumThreadTwin.new(options["model"])
    twin.change_title!
    twin.change_body(options["current_user"])
    twin.sync

    options["error"] = ERRORS::TWIN_SYNC_ERROR unless twin.changed?(:title) && twin.changed?(:body)
  end

  def errors(options, **)
    #TODO Log Errors here
  end
end
