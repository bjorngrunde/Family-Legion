class Flrs::EventsController < ApplicationController
  before_action :require_login

  def index
    result = run Event::Index
    render cell(Event::Cell::Index, result["model"], context: { current_user: current_user })
  end

  def new
    result = run Event::New
    render cell(Event::Cell::New, result["model"], context: { current_user: current_user, form: result["contract.default"] })
  end

  def create
    result= run Event::Create
    return redirect_to flrs_event_path(result["model"]), flashy(:positive, "", t(:event_created)) if result.success?
    render cell(Event::Cell::New, result["model"], context: { current_user: current_user, form: result["contract.default"] })
  end

  def show
    result = run Event::Show
    render cell(Event::Cell::Show, result["model"], context: { current_user: current_user, invite: result["invite"] })
  end

  def edit
    result = run Event::Edit
    render cell(Event::Cell::Edit, result["model"], context: { current_user: current_user, form: result["contract.default"]})
  end

  def update
    result = run Event::Update
    return redirect_to flrs_event_path(result["model"]), flashy(:positive, t(:oh_yeah), t(:event_updated)) if result.success?
    render cell(Event::Cell::Edit, result["model"], context: { current_user: current_user, form: result["contract.default"]})
  end

  def sign_up
    run Event::SignUp do |result|
      redirect_back(fallback_location: dashboard_path, flash: flashy(:positive, t(:oh_yeah), t(:you_signed_up)) )
    end
  end
end
