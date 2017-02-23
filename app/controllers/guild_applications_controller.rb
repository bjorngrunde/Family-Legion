class GuildApplicationsController < ApplicationController
  layout 'layouts/landing_page'
  before_filter only: :new do
    redirect_to dashboard_path if tyrant.signed_in?
  end

  def new
    result = run GuildApplication::New
    render cell(GuildApplication::Cell::New, result["model"], context: { form: result["contract.default"], flash: flash})
  end

  def create
    result = run GuildApplication::Create
    if result.success?
      return redirect_to register_path, :positive => { :header => t(:oh_yeah), :content => t(:successfull_register) }
    end
    render cell(GuildApplication::Cell::New, result["model"], context: { form: result["contract.default"] })
  end
end
