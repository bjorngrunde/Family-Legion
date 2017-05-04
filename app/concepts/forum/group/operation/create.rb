class Forum::Group::Create < Trailblazer::Operation

  step Model(ForumGroup, :new)
  step Policy::Pundit(ForumPolicy, :create?)
  step Contract::Build(constant: Forum::Group::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
end
