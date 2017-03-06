class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :positive, :negative, :warning, :info
  layout 'layouts/application'
  
  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant
  
  def require_login
    redirect_to root_path unless tyrant.signed_in?
  end

  def not_authorized!
    redirect_to dashboard_path, :warning => { :header => t(:oh_dear), content: t(:not_authorized)}
  end
  
  private
  def _run_options(options)
    options.merge( "current_user" => tyrant.current_user )
  end
end
