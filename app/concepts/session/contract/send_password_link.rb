module Session::Contract
  class SendPasswordLink < Reform::Form
    
    property :email, virtual: true
    property :auth_meta_data
    
    validates :email, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i } 
  end
end