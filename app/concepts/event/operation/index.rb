class Event::Index < Trailblazer::Operation

  step :find_all!

  def find_all!(options, params:, **)
    options["model"] = Event.today_and_forward.includes(:invites).where("invites.user_id = ? OR guild_event = ? OR public = ?", options["current_user"].id, true, true).references(:invites).page(params[:page]).per(16)
  end
end
