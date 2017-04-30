module Dungeon::Cell
  class Form < Familylegion::Cell::Master
    extend  Paperdragon::Model::Reader

    processable_reader :image
    property :image_meta_data

    def dungeon_image
      image_tag(image[:original].url, class: "ui image") if image.exists?
    end
  end
end
