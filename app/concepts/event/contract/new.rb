module Event::Contract
  class New < Reform::Form
    property :name
    property :description
    property :difficulty
    property :public
    property :guild_event
    property :start_time
    property :end_time
    property :start_date
    property :dungeon_id

    validates :name, :difficulty, :public, :start_date, :start_time, :end_time, presence: true, allow_blank: false
    validates :name, length: { minimum: 5 }
    validates :description, length: { maximum: 725 }, allow_blank: true
  end
end
