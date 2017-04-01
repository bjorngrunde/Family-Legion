class Forum::ShowCategory < Trailblazer::Operation

  step Model(ForumCategory, :find_by)
  step Policy::Pundit(ForumPolicy, :read?)
  step Contract::Build(constant: Forum::Contract::Category)
end
