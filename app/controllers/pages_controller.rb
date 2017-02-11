class PagesController < ApplicationController
  layout 'layouts/landing_page', only: :index

  def index
  end

  def dashboard
  end
end
