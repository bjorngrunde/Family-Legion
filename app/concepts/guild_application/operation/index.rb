class GuildApplication::Index < Trailblazer::Operation

  step :get_all_or_pending!
  step Policy::Pundit(GuildApplicationPolicy, :list?)


  private

  def get_all_or_pending!(options, params:, **)
    return options["model"] = GuildApplication.is_pending.order(:first_name).page(params[:page]) if params[:status]
    return options["model"] = GuildApplication.order(:first_name).page(params[:page]).per(15) unless params[:term]
    options["model"] = GuildApplication.where("first_name LIKE :term OR last_name LIKE :term", term: "%#{params[:term]}%" ).page(params[:page])
  end
end
