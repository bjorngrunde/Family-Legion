class Forum::UpdateCategory < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :update?)
  step Contract::Build(constant: Forum::Contract::Category)
  step Contract::Validate()
  step Contract::Persist()
end
