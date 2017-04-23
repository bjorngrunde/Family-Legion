class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :positive, :negative, :warning, :info
  layout 'layouts/application'

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant

  def current_user
    tyrant.current_user
  end

  def require_login
    redirect_to root_path unless tyrant.signed_in?
  end

  def not_authorized!
    redirect_to dashboard_path, :warning => { :header => t(:oh_dear), content: t(:not_authorized)} unless params[:username] == current_user.username
  end

  def flashy(type, header, content)
    {type => { :header => header, :content => content} }
  end

  def policy_breach!
    redirect_to dashboard_path, flashy(:warning, t(:oh_dear), t(:policy_breach_text))
  end

  def negative_flash
    flashy(:warning, t(:oh_dear), t(:something_went_wrong))
  end

  def flash_errors contract
    contract.errors.map { |error, message| t(message.split(".").last.to_sym) }
  end

  private
  def _run_options(options)
    options.merge( "current_user" => tyrant.current_user )
  end
end
