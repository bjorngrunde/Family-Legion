class PagesController < ApplicationController
  layout 'layouts/landing_page', only: :index

  before_filter only: :index do
    redirect_to dashboard_path if tyrant.signed_in?
  end

  def index
  end

  def dashboard
  end
end
