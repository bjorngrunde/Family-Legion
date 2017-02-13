class GuildApplicationsController < ApplicationController
  layout 'layouts/landing_page'

  def new
    result = run GuildApplication::New
    render cell(GuildApplication::Cell::New, result["model"], context: { form: result["contract.default"] })
  end

  def create
    result = run GuildApplication::Create
    if result.success?
      return redirect_to register_path, :positive => { :header => t(:oh_yeah), :content => t(:successfull_register) }
    end
    render cell(GuildApplication::Cell::New, result["model"], context: { form: result["contract.default"] })
  end
end
