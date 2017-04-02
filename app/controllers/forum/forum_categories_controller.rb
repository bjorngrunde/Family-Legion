class Forum::ForumCategoriesController < ApplicationController
  before_action :require_login

  def create
    result = run Forum::CreateCategory
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to forum_index_path, flashy(:negative, t(:oh_dear), t(:something_went_wrong)) if result.failure?
    return redirect_to forum_index_path, flashy(:positive, t(:oh_yeah), t(:category_created)) if result.success?
  end

  def show
    result = run Forum::ShowCategory
    return policy_breach! if result["result.policy.default"].failure?
    render cell(Forum::Cell::ShowCategory, result["model"], context: { current_user: current_user, threads: result["threads"]})
  end
end
