class Setting::AltsController < ApplicationController
  before_action :require_login
  before_action :not_authorized!

  def new
    result = run Alt::New
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"] })
  end

  def create
    result = run Alt::Create
    return redirect_to user_setting_alts_path(), flashy(:positive, t(:oh_yeah), t(:alt_created)) if result.success?
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"] })
  end

  def index
    run Alt::Index do |result|
      render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Index", current_user: tyrant.current_user, form: result["contract.default"]})
    end
  end

  def edit
    run Alt::Edit do |result|
      render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"]})
    end
  end

  def update
    result = run Alt::Update
    return redirect_to edit_user_setting_alt_path(result["model"]), flashy(:positive, t(:oh_yeah), t(:successfull_save) ) if result.success?
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"]})
  end

  def destroy
    result = run Alt::Destroy
    return redirect_to user_setting_alts_path, flashy(:positive, t(:oh_yeah), t(:successfull_delete)) if result.success?
  end

  def change_main_character
    #TODO: Needs error checking later
    result = run Alt::ChangeMainCharacter
    tyrant.current_user.reload #Kinda needed here :(
    redirect_to user_setting_alts_path(username: tyrant.current_user.username), flashy(:positive, t(:oh_yeah), t(:you_changed_character, alt: result["model"].name.humanize, main: tyrant.current_user.username.humanize))
  end
end