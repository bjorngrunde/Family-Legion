class CommentsController < ApplicationController
  before_action :require_login

  def create
    result = run Comment::Create
    return render js: cell(Comment::Cell::Discussion, result["model"]).(:append) if result.success?
  end

  def create_sub_comment
    result = run Comment::Create
    return render js: cell(Comment::Cell::SubReply, result["model"]).(:append) if result.success?
  end

  def index
    result = run Comment::Index
    render js: cell(Comment::Cell::Show, result["model"], context: { page: params[:page] } ).(:append)
  end

  def sub_comments
    result = run Comment::SubComment
    return render js: cell(Comment::Cell::SubReply, collection: result["model"]).(:prepend) if result.success?
  end
end
