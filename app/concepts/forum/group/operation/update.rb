class Forum::Group::Update < Trailblazer::Operation

  step Model(ForumGroup, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
  step Contract::Build(constant: Forum::Group::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
end
