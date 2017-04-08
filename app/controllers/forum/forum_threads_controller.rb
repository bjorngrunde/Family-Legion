class Forum::ForumThreadsController < ApplicationController

  def new
    result = run Forum::Thread::New
    render cell(Forum::Thread::Cell::New, result["model"], context: { category: result["category"], group: result["group"], form: result["contract.default"], current_user: current_user})
  end

  def create
    result = run Forum::Thread::Create
    return redirect_to forum_show_thread_path(thread: result["model"].slug, category: result["model"].forum_category.slug, group: result["model"].forum_group.slug) if result.success?
  end

  def show
    result = run Forum::Thread::Show
    render cell(Forum::Thread::Cell::Show, result["model"], context: { current_user: current_user })
  end
end
