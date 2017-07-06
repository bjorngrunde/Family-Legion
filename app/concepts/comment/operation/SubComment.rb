class Comment::SubComment < Trailblazer::Operation

  step :load_sub_comments!

  def load_sub_comments!(options, params:, **)
    options["model"] = Comment.where(commentable_id: params[:id]).order(created_at: :desc).offset(2)
  end
end