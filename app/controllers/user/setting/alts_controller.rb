class User::Setting::AltsController < ApplicationController
  before_action :require_login

  def new
    result = run Alt::New
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"] })
  end

  def create
    result = run Alt::Create
    return redirect_to user_setting_alts_path(), :positive => { :header => t(:oh_yeah), :content => t(:alt_created) } if result.success?
    not_authorized if result["result.policy.default"].failure?
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"] })
  end

  def index
    run Alt::Index do |result|
      render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Index", current_user: tyrant.current_user, form: result["contract.default"]})
    end
  end

  def edit
    run Alt::Edit do |result|
      not_authorized if result["result.policy.default"].failure?
      render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"]})
    end
  end

  def update
    result = run Alt::Update
    return redirect_to edit_user_setting_alt_path(result["model"]), :positive => { :header => t(:oh_yeah), :content => t(:successfull_save) } if result.success?
    not_authorized if result["result.policy.default"].failure?
    render cell(Familylegion::Cell::Setting, result["model"], context: { cell_view: "Alt::Cell::Form", current_user: tyrant.current_user, form: result["contract.default"]})
  end

  def destroy
    result = run Alt::Destroy
    return redirect_to user_setting_alts_path, :positive => { :header => t(:oh_yeah), :content => t(:successfull_delete)} if result.success?
    not_authorized if result["result.policy.default"].failure?
  end
end