class CommentsController < ApplicationController
  before_action :require_login

  def create
    result = run Comment::Create
    return redirect_back(fallback_location: dashboard_path) if result.success?
  end

  def index
    result = run Comment::Index
    render status: 201, json: CommentRepresenter.for_collection.new(result["comments"]).to_json if result.success?
  end
end
