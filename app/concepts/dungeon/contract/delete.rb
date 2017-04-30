module Dungeon::Contract
  class Delete < Reform::Form
    extend  Paperdragon::Model::Reader

    property :image_meta_data
    processable_reader :image
  end
end
