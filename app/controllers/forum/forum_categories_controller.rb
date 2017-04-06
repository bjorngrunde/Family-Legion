class Forum::ForumCategoriesController < ApplicationController
  before_action :require_login

  def create
    result = run Forum::Category::Create
    return policy_breach! if result["result.policy.default"].failure?
    flash = result.success? ? flashy(:positive, t(:oh_yeah), t(:category_created)) : negative_flash
    return redirect_to forum_index_path, flash
  end

  def show
    result = run Forum::Category::Show
    return policy_breach! if result["result.policy.default"].failure?
    render cell(Forum::Category::Cell::Show, result["model"], context: { current_user: current_user, threads: result["threads"]})
  end

  def edit
    result = run Forum::Category::Edit
    render status: 422, json: { errors: t(:something_went_wrong)} if result.failure?
    render status: 302, json: ForumCategoryRepresenter.new(result["model"]).to_json if result.success?
  end

  def update
    result = run Forum::UpdateCategory
    flash = result.success? ? flashy(:positive, t(:oh_yeah), t(:forum_category_updated)) : negative_flash
    return redirect_to forum_index_path, flash
  end
end
