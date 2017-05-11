class Event::SelectPlayers < Trailblazer::Operation

  step Model(Event, :find_by)
  step :find_invites!

  def find_invites!(options, params:, **)
    users = params[:selected][:players].map { |id| id.to_i unless id.empty? }
    options["model"].invites.where(id: users).update_all(status: :selected)
  end
end
