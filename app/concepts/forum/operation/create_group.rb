class Forum::CreateGroup < Trailblazer::Operation

  step Model(ForumGroup, :new)
  step Policy::Pundit(ForumPolicy, :create?)
  step Contract::Build(constant: Forum::Contract::Group)
  step Contract::Validate()
  step Contract::Persist()
end
