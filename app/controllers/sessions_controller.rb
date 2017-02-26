class SessionsController < ApplicationController
  layout 'layouts/landing_page', only: :forgot_password
  
  def sign_in
    result = run Session::SignIn
    if result.success?
      tyrant.sign_in!(result["model"])
      return redirect_to dashboard_path
    end
    redirect_to root_path
  end
  
  def sign_out
    tyrant.sign_out!
    redirect_to root_path
  end
  
  def forgot_password
  end
  
  def send_password_link
    result = run Session::SendPasswordLink
    return redirect_to forgot_password_path, :positive => { :header => t(:oh_yeah), content: t(:password_email_is_sent)} if result.success?
    return redirect_to forgot_password_path, :negative => { :header => t(:oh_dear), content: t(result["error"].to_sym)} if result.failure?
  end
end
