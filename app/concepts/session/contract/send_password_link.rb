module Session::Contract
  class SendPasswordLink < Reform::Form
    
    property :email, virtual: true
    
    validates :email, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i } 
  end
end