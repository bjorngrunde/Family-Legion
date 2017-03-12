class Setting::ProfilesController < ApplicationController
  before_action :require_login
  before_action :not_authorized!

  def edit
    result = run Profile::Edit
    render cell( Familylegion::Cell::Setting, result["model"], context: { cell_view: "Profile::Cell::Edit", form: result["contract.default"], current_user: tyrant.current_user})
  end

  def update
    result = run Profile::Update
    return redirect_to edit_user_setting_profile_path(username: tyrant.current_user.username, id: result["model"].id), flashy(:positive, t(:oh_yeah), t(:successfull_save)) if result.success?
    render cell( Familylegion::Cell::Setting, result["model"], context: { cell_view: "Profile::Cell::Edit", form: result["contract.default"], current_user: tyrant.current_user})
  end
end