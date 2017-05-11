class Event::Index < Trailblazer::Operation

  step :find_all!

  def find_all!(options, params:, **)
    options["model"] = Event.page(params[:page]).per(16)
  end
end
