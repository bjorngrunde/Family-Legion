class Forum::UpdateGroup < Trailblazer::Operation

  step Model(ForumGroup, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
  step Contract::Build(constant: Forum::Contract::Group)
  step Contract::Validate()
  step Contract::Persist()
end
