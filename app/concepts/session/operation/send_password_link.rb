class Session::SendPasswordLink < Trailblazer::Operation
  
  step :find_user!
  failure :email_not_found_error!
  step Contract::Build(constant: Session::Contract::SendPasswordLink)
  step Contract::Validate()
  step :create_token!
  
  def find_user!(options, params:, **)
    options["model"] = User.find_by(email: params[:email])
  end
  
  def email_not_found_error!(options, **)
    options["error"] = "email_not_found"
  end
  
  def create_token!(options, **)
    auth = Tyrant::Authenticatable.new(options["model"])
    auth.confirmable!
    auth.sync
    #raise options["model"].auth_meta_data.inspect
    auth.confirmed!
    auth.sync
  end
  
  def save_model!(options, **)
    options["model"].save
  end
  
  def send_password_link(options, **)
    
  end
end