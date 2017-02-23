class Session::SignIn < Trailblazer::Operation
  extend Contract::DSL
  
  step Contract::Build()
  step Contract::Validate()
  step :set_user!
  
  contract do
    property  :email, virtual: true
    property  :password, virtual: true
    validates :email, :password, presence: true
    validate :password_ok?
    attr_reader :user
    
    private
    def password_ok?
      return if email.blank? or password.blank?
      @user = User.find_by(email: email)
      errors.add(:password, "Wrong password.") unless @user and \
      Tyrant::Authenticatable.new(@user).digest?(password)
    end
  end

  def set_user!(options, **)
    options["model"] = options["contract.default"].user
  end
end