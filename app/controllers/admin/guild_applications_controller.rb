class Admin::GuildApplicationsController < AdminController

  def index
    result = run GuildApplication::Index
    render cell(GuildApplication::Cell::Table, result["model"])
  end

  def show
    result = run GuildApplication::Show
    render cell(GuildApplication::Cell::Show, result["model"])
  end

  def edit
    result = run GuildApplication::Edit
    render cell(GuildApplication::Cell::Edit, result["model"], context: { form: result["contract.default"] })
  end

  def update
    result = run GuildApplication::Update
    if result.success?
      flash[:positive] = { header: t(:oh_yeah), content: t(:successfull_save)}
      return render cell(GuildApplication::Cell::Edit, result["model"],  context: { form: result["contract.default"] })
    end
    render cell(GuildApplication::Cell::Edit, result["model"], context: { form: result["contract.default"] })
  end

  def destroy
    result = run GuildApplication::Destroy
    if  result.success?
      return redirect_to admin_guild_applications_path, flash: { positive: { header: t(:oh_yeah), content: t(:successfull_delete) }}
    end
    flash[:negative] = { header: t(:oh_dear), content: t(:unsuccessfull_delete)}
    render cell(GuildApplication::Cell::Show, result["model"])
  end
end
