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

  end

  def update

  end

  def delete

  end

  def move

  end

  def pin

  end

  def lock

  end

  def copy

  end
end
