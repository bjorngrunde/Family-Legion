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

  def edit
    result = run Forum::EditGroup
    render status: 302, json: { title: result["model"].title, id: result["model"].id, role: result["model"].role } if result.success?
    render status: 401, json: { errors: "Not Authorized!!"} if result["result.policy.default"].failure?
  end

  def update
    result = run Forum::UpdateGroup
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to forum_index_path, flashy(:positive, t(:oh_yeah), t(:group_updated) ) if result.success?
    return redirect_to forum_index_path, flashy(:negative, t(:oh_dear), t(:something_went_wrong) ) if result.failure?
  end
end
