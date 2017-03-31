class Forum::ForumGroupsController < ApplicationController
  before_action :require_login

  def index
    result = run Forum::Index
    render cell(Forum::Cell::Index, result["model"], context: { current_user: current_user})
  end
end
