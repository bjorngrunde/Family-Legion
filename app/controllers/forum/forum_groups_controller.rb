class Forum::ForumGroupsController < ApplicationController
  before_action :require_login

  def index
    result = run Forum::Index
    render cell(Forum::Cell::Index, result["model"], context: { current_user: current_user})
  end

  def create
    result = run Forum::CreateGroup
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to forum_index_path, flashy(:positive, t(:oh_yeah), t(:forum_group_created)) if result.success?
  end
end
