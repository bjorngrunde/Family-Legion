module Forum::Thread::Contract
  class Move < Reform::Form

    property :forum_category_id
    property :forum_group_id

    validates :forum_group_id, :forum_category_id, presence: true
  end
end
