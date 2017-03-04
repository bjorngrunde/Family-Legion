class ProfilesController < ApplicationController
  before_action :require_login

  def show
    result = run Profile::Show
    render cell(Profile::Cell::Show, result["model"], context: { current_user: tyrant.current_user, items: result["model"].profile.profile_meta_data[:items]})
  end
end
