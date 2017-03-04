module Alt::Contract
  class New < Reform::Form
    property  :name
    property  :klass
    property  :server

    validates :name, :klass, :server, presence: true
    validate :can_not_be_user!

    def can_not_be_user!
      errors.add(:name, :cannot_add_existing_user_as_alt) if User.find_by(username: name)
    end
  end
end