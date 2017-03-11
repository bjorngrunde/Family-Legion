class GuildApplication::Index < Trailblazer::Operation

  step :get_all_or_pending!


  private

  def get_all_or_pending!(options, params:, **)
    return options["model"] = GuildApplication.is_pending if params[:status]
    return options["model"] = GuildApplication.order(:first_name).page(options["params"]["page"]).per(15) unless options["params"]["term"]
    options["model"] = GuildApplication.where("first_name LIKE :term OR last_name LIKE :term", term: "%#{options["params"]["term"]}%" ).page(options["params"]["page"])
  end
end
