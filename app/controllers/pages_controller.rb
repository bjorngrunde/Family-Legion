class PagesController < ApplicationController
  layout 'layouts/landing_page', only: :index

  before_action only: :index do
    redirect_to dashboard_path if tyrant.signed_in?
  end
  before_action :require_login, except: :index

  def index
  end

  def dashboard
  end
end
