class Forum::ForumGroupsController < ApplicationController
  before_action :require_login


  def index
    result = run Forum::Index
    add_breadcrumb I18n.t("breadcrumbs.forum_overview"), :forum_overview_path
    render cell(Forum::Cell::Index, result["model"], context: { current_user: current_user})
  end

  def create
    result = run Forum::Group::Create
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to forum_overview_path, flashy(:positive, t(:oh_yeah), t(:forum_group_created)) if result.success?
    redirect_back(fallback_location: dashboard_path, flash: flashy(:negative, "", t(:something_went_wrong)))
  end

  def edit
    result = run Forum::Group::Edit
    render status: 302, json: { title: result["model"].title, id: result["model"].id, role: result["model"].role } if result.success?
    render status: 422, json: { errors: t(:something_went_wrong)} if result.failure?
  end

  def update
    result = run Forum::Group::Update
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to forum_overview_path, flashy(:positive, t(:oh_yeah), t(:group_updated) ) if result.success?
    return redirect_to forum_overview_path, flashy(:negative, t(:oh_dear), t(:something_went_wrong) ) if result.failure?
  end

  def delete
    result = run Forum::Group::Delete
    return policy_breach! if result["result.policy.default"].failure?
    redirect_back(fallback_location: dashboard_path, flash: flashy(:warning, "", t(:successfull_delete)) ) if result.success?
  end
end
