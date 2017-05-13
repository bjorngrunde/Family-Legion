class Dungeon < ApplicationRecord
  serialize :image_meta_data

  enum dungeon_type: { raid: 0, dungeon: 1, scenario: 2, pvp: 3 }

  include Paperdragon::Model
  processable :dungeon_image

  has_many :events
end
