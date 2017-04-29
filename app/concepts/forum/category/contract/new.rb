module Forum::Category::Contract
  class New < Reform::Form
    property :title
    property :description
    property :forum_group_id
    property :role

    validates :title, :description, :forum_group_id, :role, presence: true, allow_blank: false
    validates :title, length: { minimum: 5 }
    validates_uniqueness_of :title
  end
end
