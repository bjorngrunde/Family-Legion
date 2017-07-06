class Comment::Index < Trailblazer::Operation

  step :get_model!

  def get_model!(options, params:, **)
    options["model"] = params[:model].constantize.find_by(id: params[:id])
  end
end
