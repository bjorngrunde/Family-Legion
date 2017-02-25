module Setting::Contract
  class ChangePassword < Reform::Form

    property :old_password, virtual: true
    property :new_password, virtual: true
    property :confirm_new_password, virtual: true
    property :auth_meta_data

    validates :old_password, :new_password, :confirm_new_password, presence: true
    validate :new_password_match!

    def new_password_match!
      errors.add(:new_password, "Passwords dont match!") if new_password != confirm_new_password
    end
  end
end