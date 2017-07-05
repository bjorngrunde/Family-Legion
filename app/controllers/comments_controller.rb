class CommentsController < ApplicationController
  before_action :require_login

  def create
    result = run Comment::Create
    return render status: 200, json: CommentRepresenter.new(result["model"]).to_json if result.success?
  end

  def index
    result = run Comment::Index
    render js: cell(Comment::Cell::Show, result["model"], context: { page: params[:page] } ).(:append)
  end

  def sub_comments
    result = run Comment::SubComment
    render status: 200, json: CommentRepresenter.for_collection.new(result["model"]).to_json if result.success?
    render status: 422, json: { error: t(:something_went_wrong) } if result.failure?
  end
end
