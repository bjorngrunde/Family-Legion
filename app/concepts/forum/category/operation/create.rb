class Forum::Category::Create < Trailblazer::Operation

  step Model(ForumCategory, :new)
  step Policy::Pundit(ForumPolicy, :create?)
  step Contract::Build(constant: Forum::Category::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
end
