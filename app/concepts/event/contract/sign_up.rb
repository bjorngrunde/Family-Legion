module Event::Contract
  class SignUp < Reform::Form

      property :status
      property :role
      property :notice
      property :user_id
      property :inviteable_type
      property :inviteable_id

      validates :status, :role, :user_id, presence: true, allow_blank: false
      validates :notice, allow_blank: true, length: { maximum: 75 }
  end
end
