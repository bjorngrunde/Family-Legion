class PagesController < ApplicationController
  layout 'layouts/landing_page', only: :index

  def index
    result = run Session::SignIn
  end

  def dashboard
  end
end
