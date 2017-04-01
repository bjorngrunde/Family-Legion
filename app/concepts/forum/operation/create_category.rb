class Forum::CreateCategory < Trailblazer::Operation

  step Model(ForumCategory, :new)
  step Policy::Pundit(ForumPolicy, :create?)
  step Contract::Build(constant: Forum::Contract::Category)
  step Contract::Validate()
  step Contract::Persist()
end
