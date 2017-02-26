class Admin::PagesController < AdminController
  before_filter :require_login
  
  def control_panel
  end
end
