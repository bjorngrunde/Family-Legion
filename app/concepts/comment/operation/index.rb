class Comment::Index < Trailblazer::Operation

  step ->(options, params:, **) { options["comments"] = Comment.where(commentable_id: params[:id], commentable_type: params[:model]).order(:created_at).limit(10) }

end
