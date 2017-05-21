class Event::Index < Trailblazer::Operation

  step :find_all!

  def find_all!(options, params:, **)
    return options["model"] = Event.today_and_forward.public_or_invited(options["current_user"].id, true, true).page(params[:page]).per(16) unless options["current_user"].has_role?(:admin)
    options["model"] = Event.today_and_forward.page(params[:page]).per(16)
  end
end
