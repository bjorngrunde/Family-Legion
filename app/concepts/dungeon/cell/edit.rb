module Dungeon::Cell
  class Edit < Familylegion::Cell::Master
    extend  Paperdragon::Model::Reader

    processable_reader :image
    property :image_meta_data
  end
end
