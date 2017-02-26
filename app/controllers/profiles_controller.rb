class ProfilesController < ApplicationController
  before_filter :require_login
end
