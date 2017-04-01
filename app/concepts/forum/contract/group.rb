module Forum::Contract
  class Group < Reform::Form

    property :title
    property :role

    validates :role, :title, presence: true, allow_blank: false
    validates_uniqueness_of :title
  end
end
