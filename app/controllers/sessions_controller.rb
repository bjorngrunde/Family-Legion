class SessionsController < ApplicationController

  def sign_in
    result = run Session::SignIn
    if result.success?
      tyrant.sign_in!(result["model"])
      return redirect_to dashboard_path
    end

    redirect_to root_path
  end
end
