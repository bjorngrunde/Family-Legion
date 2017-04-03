class Forum::EditGroup < Trailblazer::Operation

  step Model(ForumGroup, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
end
