class Forum::Index < Trailblazer::Operation

  step :build!

  def build!(options, **)
    options["model"] = ForumGroup.all
  end
end
