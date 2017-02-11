class GuildApplication::Index < Trailblazer::Operation

  step :get_all_or_pending!


  private
  def get_all_or_pending!(options, params:, **)
    return options["model"] = GuildApplication.where(status: params[:status]) if params[:status]
    options["model"] = GuildApplication.all
  end
end
