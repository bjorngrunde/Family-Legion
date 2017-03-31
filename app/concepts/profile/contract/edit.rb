module Profile::Contract
  class Edit < Reform::Form
    
    property  :first_name
    property  :last_name
    property  :server
    property  :phone
    property  :spec
    property  :klass
    property  :thumbnail
    property  :avatar
    property  :profile_meta_data

    validates :first_name, :last_name, :server, presence: true

    property :user do
      property :email
      property :username

      validates :email, :username, presence: true
      validates_uniqueness_of :username
      validates_uniqueness_of :email
      validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    end
  end
end