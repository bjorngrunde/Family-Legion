class Image::ImageManagerController < ApplicationController

  before_action :require_login

  def create
    result = run ImageManager::Upload
    render status: 201, json: { :url => result["model"].image[:original].url } if result.success?
    render status: 422, json: { :errors => "Image must be less then 2mb and in the format .png or .jpg"} if result.failure?
  end
end
