class Forum::Comment::Quote < Trailblazer::Operation

  step Model(ForumComment, :find_by)
end
