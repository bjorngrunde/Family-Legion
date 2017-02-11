class GuildApplicationsController < ApplicationController
  layout 'layouts/landing_page'

  def new
  end

  def create
    run GuildApplication::Create do
      flash[:positive] = t(:successfull_register)
      return redirect_to register_path
    end
    flash[:warning] = { header: t(:oh_dear), content: t(:unsuccessfull_register)}
    render :new
  end
end
