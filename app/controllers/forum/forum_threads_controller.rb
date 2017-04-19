class Forum::ForumThreadsController < ApplicationController
  before_action :require_login

  add_breadcrumb I18n.t("breadcrumbs.forum_overview"), :forum_overview_path

  def new
    result = run Forum::Thread::New

    add_breadcrumb I18n.t("breadcrumbs.forum_category", category: result["category"].titleize.gsub("-", " ")), forum_show_category_path(group: result["group"], category: result["category"])
    add_breadcrumb I18n.t("breadcrumbs.forum_create_thread", :forum_create_thread_path)

    render cell(Forum::Thread::Cell::New, result["model"], context: { category: result["category"], group: result["group"], form: result["contract.default"], current_user: current_user})
  end

  def create
    result = run Forum::Thread::Create
    return redirect_to forum_show_thread_path(thread: result["model"].slug, category: result["model"].forum_category.slug, group: result["model"].forum_group.slug) if result.success?
  end

  def show
    result = run Forum::Thread::Show

    add_breadcrumb I18n.t("breadcrumbs.forum_category", category: result["model"].forum_category.title), forum_show_category_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug)
    add_breadcrumb I18n.t("breadcrumbs.forum_thread", thread: result["model"].title), forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug)

    render cell(Forum::Thread::Cell::Show, result["model"], context: { current_user: current_user, comments: result["comments"], page: params[:page] })
  end

  def edit
    result = run Forum::Thread::Edit

    add_breadcrumb I18n.t("breadcrumbs.forum_category", category: result["model"].forum_category.title), forum_show_category_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug)
    add_breadcrumb I18n.t("breadcrumbs.forum_thread", thread: result["model"].title), forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug)
    add_breadcrumb I18n.t("breadcrumbs.edit")

    render cell(Forum::Thread::Cell::Edit, result["model"], context: { current_user: current_user, form: result["contract.default"]})
  end

  def update
    result = run Forum::Thread::Update
    return policy_breach! if result["result.policy.default"].failure?
    return redirect_to forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug) if result.success?
    render cell(Forum::Thread::Cell::Edit, result["model"], context: { current_user: current_user, form: result["contract.default"]})
  end

  def delete
    result = run Forum::Thread::Delete
    redirect_to forum_overview_path, flashy(:positive, t(:oh_yeah), t(:forum_thread_destroyed))
  end

  def move
    result = run Forum::Thread::Move
    return redirect_to forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug) if result.success?
  end

  def pin
    result = run Forum::Thread::Pin
    redirect_to forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug) if result.success?
  end

  def lock
    result = run Forum::Thread::Lock
    redirect_to forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug) if result.success?
  end

  def copy
    result = run Forum::Thread::Copy
    redirect_to forum_show_thread_path(group: result["model"].forum_group.slug, category: result["model"].forum_category.slug, thread: result["model"].slug) if result.success?
    redirect_to(:back, flashy(:negative, t(:oh_dear), t(result["error"]))) if result.failure?
  end
end
