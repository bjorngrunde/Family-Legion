class GuildApplication::ToggleStatus < Trailblazer::Operation

  step Model(GuildApplication, :find_by)
  step :change_status!

  def change_status!(options, params:, **)
    options["model"].status = params[:status]
    options["model"].save
  end
end
