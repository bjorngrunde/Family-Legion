class ProfilesController < ApplicationController
  before_action :require_login

  def show
    result = run Profile::Show
    return redirect_to dashboard_path, flashy(:warning, t(:oh_dear), result["flash"]) if result.failure?
    render cell(Profile::Cell::Show, result["model"], context: { current_user: tyrant.current_user, items: result["model"].profile.profile_meta_data[:items], talents: result["model"].profile.profile_meta_data[:talents]})
  end
end
