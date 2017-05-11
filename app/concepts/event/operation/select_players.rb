class Event::SelectPlayers < Trailblazer::Operation

  step Model(Event, :find_by)
  step :find_invites!

  def find_invites!(options, params:, **)
    options["model"].invites.where(id: params[:selected_players]).update_all(status: :selected)
  end
end