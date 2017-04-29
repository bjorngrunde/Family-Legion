class Admin::DungeonsController < AdminController
  before_action :require_login

  add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path
  add_breadcrumb I18n.t("breadcrumbs.dungeons"), :admin_dungeons_path, :only => %w(index show edit new)
  add_breadcrumb I18n.t("breadcrumbs.new"), :new_admin_dungeon_path, :only => %w(new)
  add_breadcrumb I18n.t("breadcrumbs.edit"), :edit_dungeon_path, :only => %w(edit)

  def new
    result = run Dungeon::New
    render cell( Dungeon::Cell::New, result["model"], context: { current_user: current_user, form: result["contract.default"]} )
  end

  def create
    result = run Dungeon::Create
    return redirect_back(fallback_location: admin_control_panel_path, flash: flashy(:positive, "", t(:dungeon_saved)) ) if result.success?
    render cell( Dungeon::Cell::New, result["model"], context: { current_user: current_user, form: result["contract.default"]} )
  end

  def index
    result = run Dungeon::Index
    render cell(Dungeon::Cell::Index, result["model"], context: { current_user: current_user })
  end
end
