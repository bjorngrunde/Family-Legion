module ImageManager::Contract
  class Upload < Reform::Form

    property :file, virtual: true

    validates :file, file_size: { less_than: 2.megabytes }, file_content_type: { allow: ['image/jpeg', 'image/png'] }
  end
end
