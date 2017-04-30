class Dungeon::Index < Trailblazer::Operation

  step :get_all_dungeons!

  def get_all_dungeons!(options, params:, **)
    options["model"] = Dungeon.order(:name).page(params[:page]).per(15)
  end
end
