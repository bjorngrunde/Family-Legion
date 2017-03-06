module Alt::Contract
  class New < Reform::Form
    property  :name
    property  :klass
    property  :server

    validates :name, :klass, :server, presence: true
    validates_uniqueness_of :name
    validate :cannot_be_user!

    def cannot_be_user!
      errors.add(:name, :cannot_add_existing_user_as_alt) if User.find_by(username: name)
    end
  end
end