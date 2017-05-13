class Comment::Create < Trailblazer::Operation

  step Model(Comment, :new)
  step Contract::Build(constant: Comment::Contract::Create)
  step Contract::Validate(key: :comment)
  step :add_user!
  step Contract::Persist()

  def add_user!(options, **)
    options["contract.default"].user = options["current_user"]
  end
end
