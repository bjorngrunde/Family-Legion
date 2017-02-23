class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :positive, :negative, :warning, :info
  layout 'layouts/application'

  before_filter only: [:index, :register] do
    redirect_to dashboard_path if tyrant.signed_in?
  end

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant
end
