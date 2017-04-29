class Forum::Group::Edit < Trailblazer::Operation

  step Model(ForumGroup, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
end
