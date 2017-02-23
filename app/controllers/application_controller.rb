class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :positive, :negative, :warning, :info
  layout 'layouts/application'

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant
end
