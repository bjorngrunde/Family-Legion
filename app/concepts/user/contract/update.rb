module User::Contract
  class Update < Reform::FormError

    validates :email, :username, presence: true
  end
end