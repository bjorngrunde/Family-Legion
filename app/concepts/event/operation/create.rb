class Event::Create < Trailblazer::Operation

  step Model(Event, :new)
  step Contract::Build(constant: Event::Contract::New)
  step Contract::Validate(key: :event)
  step :add_user!
  step Contract::Persist()
  step :add_invites!


  def add_invites!(options, params:, **)
    user_ids = params[:invites][:inviteable] << options["current_user"].id.to_s
    user_ids.each { |id| options["model"].invites.create({ user_id: id, status: :not_sure }) unless options["model"].invites.find_by(user_id: id) || id.empty? }
  end

  def add_user!(options, **)
    options["model"].user = options["current_user"]
  end
end
