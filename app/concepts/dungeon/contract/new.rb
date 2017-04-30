module Dungeon::Contract
  class New < Reform::Form
    extend Paperdragon::Model::Writer

    property :name
    property :dungeon_type
    property :image_meta_data
    property :dungeon_image, virtual: true

    processable_writer :image


    validates :dungeon_image, file_size: { less_than: 2.megabytes }, file_content_type: { allow: ['image/jpeg', 'image/png'] }
    validates :name, :dungeon_type, presence: true, allow_blank: false
    validates :name, length: { minimum: 5 }
  end
end
