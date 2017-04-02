class Forum::ForumThreadsController < ApplicationController

  def new
    result = run Forum::NewThread
    render cell(Forum::Cell::NewThread, result["model"], context: { category: result["category_id"], form: result["contract.default"], current_user: current_user})
  end

  def create
    result = run Forum::CreateThread
    return redirect_to forum_show_thread_path(url: result["model"].url, forum_category_id: result["model"].forum_category.id) if result.success?
  end

  def show
    result = run Forum::ShowThread
    render cell(Forum::Cell::ShowThread, result["model"], context: { current_user: current_user })
  end
end
