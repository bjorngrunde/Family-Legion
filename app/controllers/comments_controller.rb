class CommentsController < ApplicationController
  before_action :require_login

  def create
    result = run Comment::Create
    return redirect_back(fallback_location: dashboard_path) if result.success?
  end
end
