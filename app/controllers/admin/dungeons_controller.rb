class Admin::DungeonsController < AdminController
  before_action :require_login

  add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path
  add_breadcrumb I18n.t("breadcrumbs.dungeons"), :admin_dungeons_path, :only => %w(index show edit new)
  add_breadcrumb I18n.t("breadcrumbs.new"), :new_admin_dungeon_path, :only => %w(new)
  add_breadcrumb I18n.t("breadcrumbs.edit"), :edit_admin_dungeon_path, :only => %w(edit)

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

  def edit
    result = run Dungeon::Edit
    render cell(Dungeon::Cell::Edit, result["model"], context: { current_user: current_user , form: result["contract.default"]})
  end

  def update
    result = run Dungeon::Update
    return redirect_back(fallback_location: admin_control_panel_path, flash: flashy(:positive, t(:oh_yeah), t(:dungeon_updated)) ) if result.success?
    render cell(Dungeon::Cell::Edit, result["model"], context: { current_user: current_user , form: result["contract.default"]}) if result.failure?
  end

  def destroy
    result = run Dungeon::Delete
    flash = result.success? ? flashy(:positive, "", t(:dungeon_deleted)) : negative_flash
    redirect_back(fallback_location: admin_control_panel_path, flash: flash) if result.success?
  end
end
