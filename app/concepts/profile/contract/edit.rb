module Profile::Contract
  class Edit < Reform::Form
    require "reform/form/validation/unique_validator"
    
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
      validates :username, unique: true
      validates :email, unique: true
      validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    end
  end
end