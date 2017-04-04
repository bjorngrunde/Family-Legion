class Forum::EditCategory < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
end
