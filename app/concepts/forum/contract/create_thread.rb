module Forum::Contract
  class CreateThread < Reform::Form

    property  :title
    property  :body

    validates :title, :body, presence: true, allow_blank: false
    validates :title, length: { minimum: 5 }
  end
end
