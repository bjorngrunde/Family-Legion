class Forum::ForumCommentsController < ApplicationController
  before_action :require_login

  add_breadcrumb I18n.t("breadcrumbs.forum_overview"), :forum_overview_path

  def new
    result = run Forum::Comment::New

    add_breadcrumb I18n.t("breadcrumbs.forum_category", category: params[:category].titleize.gsub("-", " ")), forum_show_category_path(group: params[:group], category: params[:category])
    add_breadcrumb I18n.t("breadcrumbs.forum_thread", thread: params[:thread].humanize.gsub("-", " ")), forum_show_thread_path(group: params[:group], category: params[:category], thread: params[:thread])
    add_breadcrumb I18n.t("breadcrumbs.forum_new_comment", :forum_new_comment_path)

    render cell(Forum::Comment::Cell::New, result["model"], context: { form: result["contract.default"], current_user: current_user, thread: result["thread"]})
  end

  def create
    result = run Forum::Comment::Create
    return redirect_to forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_group.slug, thread: result["model"].forum_thread.slug, page: result["pages"], anchor:  "#{result["model"].id}") if result.success?
    redirect_back(fallback_location: forum_overview_path, flash: flashy(:negative, t(:oh_dear), t(:something_went_wrong)) ) if result.failure?
  end

  def delete
    result = run Forum::Comment::Delete
    return redirect_back(fallback_location: forum_overview_path, flash: flashy(:positive, "", t(:comment_deleted)) ) if result.success?
    render status: 422, nothing: true if result.failure?
  end

  def quote
    result = run Forum::Comment::Quote
    render status: 302, json: ForumCommentRepresenter.new(result["model"]).to_json if result.success?
    render status: 422, json: { error: t(:something_went_wrong)} if result.failure?
  end
end
