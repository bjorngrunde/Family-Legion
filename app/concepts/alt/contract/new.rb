module Alt::Contract
  class New < Reform::Form
    property  :username
    property  :klass
    property  :server
    property  :thumbnail

    validates :username, :klass, :server, presence: true
    validates_uniqueness_of :username
    validate :cannot_be_user!

    def cannot_be_user!
      errors.add(:username, :cannot_add_existing_user_as_alt) if User.find_by(username: username)
    end
  end
end