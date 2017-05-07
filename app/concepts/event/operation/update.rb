class Event::Update < Trailblazer::Operation
  step Model(Event, :find_by)
  step Policy::Pundit(EventPolicy, :update?)
  step Contract::Build(constant: Event::Contract::New)
  step Contract::Validate(key: :event)
  step Contract::Persist()
  success :add_invites!

  def add_invites!(options, params:, **)
    user_ids = params[:invites][:inviteable] << options["current_user"].id.to_s
    user_ids.each { |id| options["model"].invites.create({ user_id: id, status: :not_sure }) unless options["model"].invites.find_by(user_id: id) || id.empty? }
  end
end
