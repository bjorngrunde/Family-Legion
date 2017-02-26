module GuildApplication::Cell
  class Show < Trailblazer::Cell
    extend  Paperdragon::Model::Reader
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper

    property  :first_name
    property  :last_name
    property  :username
    property  :armory
    property  :klass
    property  :server
    property  :spec
    property  :played
    property  :klass_played
    property  :bio
    property  :raid_experience
    property  :reason
    property  :old_guild
    property  :progress_raid
    property  :attendance
    property  :other
    processable_reader :image
    property  :image_meta_data
    property  :status

    def readable_status
      "#{t(:status)}: #{status}".titleize
    end

    def screenshot
      image_tag(image[:original].url, class: "ui image") if image.exists?
    end

    def username
      model.username.capitalize
    end

    def klass
      model.klass.capitalize
    end

    def full_name
      "#{first_name} #{last_name}"
    end
  end
end
