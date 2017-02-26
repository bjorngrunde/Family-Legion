class Admin::PagesController < AdminController
  before_action :require_login
  
  def control_panel
  end
end
