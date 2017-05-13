class Event::Show < Trailblazer::Operation

  step Model(Event, :find_by)
  step Policy::Pundit(EventPolicy, :read?)
  step :invite_model!

  def invite_model!(options, **)
    options["invite"] = Invite.find_by(user_id: options["current_user"].id, inviteable_id: options["model"].id, inviteable_type: options["model"].class.name) || Invite.new
  end
end
