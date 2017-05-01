class Event::SignUp < Trailblazer::Operation

  step :get_model!
  step Contract::Build(constant: Event::Contract::SignUp)
  step Contract::Validate(key: :invite)
  step Contract::Persist()

  def get_model!(options, params:, **)
    options["model"] = Invite.find_by(user_id: options["current_user"].id, inviteable_type: params[:invite][:inviteable_type], inviteable_id: params[:invite][:inviteable_id]) || Invite.new
  end
end
