module Comment::Contract
  class Create < Reform::Form

    property :body
    property :commentable_type
    property :commentable_id
    property :user

    validates :body, :commentable_id, :commentable_type, presence: true, allow_blank: false
  end
end
