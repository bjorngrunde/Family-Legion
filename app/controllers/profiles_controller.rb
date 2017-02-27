class ProfilesController < ApplicationController
  before_action :require_login

  def show
    result = run Profile::Show
    render cell(Profile::Cell::Show, result["model"], context: { current_user: tyrant.current_user})
  end
end
