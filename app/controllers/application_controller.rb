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
    redirect_to dashboard_path, :warning => { :header => t(:oh_dear), content: t(:not_authorized)} unless params.select {|param| param == tyrant.current_user.username}
  end
  
  def flashy(type, header, content)
    {type => { :header => header, :content => content} }
  end
  private
  def _run_options(options)
    options.merge( "current_user" => tyrant.current_user )
  end
end
