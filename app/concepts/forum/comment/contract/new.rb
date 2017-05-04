module Forum::Comment::Contract
  class New < Reform::Form

    property  :body
    property  :forum_group_id
    property  :forum_category_id
    property  :forum_thread_id
    property  :user_id

    validates :body, :forum_group_id, :forum_category_id, :forum_thread_id, :user_id, presence: true
  end
end
