class ImageManager < ApplicationRecord
  include Paperdragon::Model
  require 'securerandom'

  class Attachment < Paperdragon::Attachment
    def build_uid(style, file)
      "/forum/uploads/#{style}/#{rename}-#{file.original_filename}"
    end

    def rename
      SecureRandom.hex(6)
    end
  end

  processable :image, Attachment

  serialize :image_meta_data

  belongs_to :user
end
