class Forum::Category::Update < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
  step Contract::Build(constant: Forum::Category::Contract::New)
  step Contract::Validate()
  step Contract::Persist()
end
