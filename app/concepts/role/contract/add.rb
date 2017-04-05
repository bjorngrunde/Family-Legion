module Role::Contract
  class Add < Role::Contract::New
    
    validates :roles, presence: true
    validate :user_has_role?

    def user_has_role?
      errors.add(:base, :user_already_has_this_role) if model.has_role? roles.to_sym
    end 
  end
end