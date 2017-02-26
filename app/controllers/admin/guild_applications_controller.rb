class Admin::GuildApplicationsController < AdminController
  before_action :require_login
  
  add_breadcrumb I18n.t("breadcrumbs.control_panel"), :admin_control_panel_path
  add_breadcrumb I18n.t("breadcrumbs.guild_applications"), :admin_guild_applications_path, :only => %w(index show edit)
  add_breadcrumb I18n.t("breadcrumbs.edit"), :edit_admin_guild_application_path, :only => %w(edit)

  def index
    result = run GuildApplication::Index
    render cell(GuildApplication::Cell::Table, result["model"])
  end

  def show
    result = run GuildApplication::Show
    add_breadcrumb I18n.t("breadcrumbs.show", user: "#{result["model"].first_name} #{result["model"].last_name}".titleize), :admin_guild_application_path, :only => %w(show edit)
    render cell(GuildApplication::Cell::Show, result["model"])
  end

  def edit
    result = run GuildApplication::Edit
    render cell(GuildApplication::Cell::Edit, result["model"], context: { form: result["contract.default"] })
  end

  def update
    result = run GuildApplication::Update
    if result.success?
      return redirect_to admin_guild_application_path(result["model"]), :positive => { :header => "", :content => t(:successfull_save)}
    end
    render cell(GuildApplication::Cell::Edit, result["model"], context: { form: result["contract.default"] })
  end

  def destroy
    result = run GuildApplication::Destroy
    if  result.success?
      return redirect_to admin_guild_applications_path, :positive => { :header => "", :content => t(:successfull_delete) }
    end
    flash = { :negative => { :header => t(:oh_dear), :content => t(:unsuccessfull_delete)}}
    render cell(GuildApplication::Cell::Show, result["model"])
  end

  def toggle_status
    result = run GuildApplication::ToggleStatus
    if result.success?
      return redirect_to admin_guild_application_path(result["model"]), :positive => { :header => t(:oh_yeah), :content => t(:you_changed_status, status: result["model"].status.humanize) }
    end
    flash = { :negative => { :header => t(:oh_dear), :content => t(:could_not_change_status)}}
    render cell(GuildApplication::Cell::Show, result["model"])
  end
end
