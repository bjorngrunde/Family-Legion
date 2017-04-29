class Forum::Comment::Delete < Trailblazer::Operation

  step Model(ForumComment, :find_by)
  step :delete!

  def delete!(options, **)
    options["model"].destroy
  end
end
