class User::Setting::AltsController < ApplicationController

  def new
    result = run Alt::New
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"] })
  end

  def create
    result = run Alt::Create
    return redirect_to user_setting_control_panel_path(id: tyrant.current_user.id), :positive => { :header => t(:oh_yeah, :content => t(:alt_created))} if result.success?
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"] })
  end
end