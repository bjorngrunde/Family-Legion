module Familylegion::Cell
  class Master < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Cell::Translation
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::FormOptionsHelper
    
    def current_user
      context[:current_user]
    end

    def form
      context[:form]
    end

    def model_css_class
      "#{model.profile.klass.sub("_", "-")}"
    end

    def current_user_css_class
      "#{current_user.profile.klass.sub("_", "-")}"
    end

    def profile_link
      link_to model.username.humanize, show_profile_path(username: model.username), class: "#{model_css_class}"
    end

    def item_link(item, type)
      if item.nil?
        image = image_tag("#{type.to_s}.png", class: "ui image", width: "36", height: "36")
        return link_to("#{image}","#", data: { tooltip: "Not equiped. True n00b!", position: "left center"}).html_safe
      end
      image = icon_image(item["icon"])
      
      link_to("#{image}", "#", class: "", rel: link_data_types(item)).html_safe
    end

    private
      def link_data_types(item)
        #Lets split everything up for readabiltiy..ish
        set = "pcs=#{item["tooltipParams"]["set"].join(":")};" unless item["tooltipParams"]["set"].nil?
        enchants = "ench=#{item["tooltipParams"]["enchant"]};"
        bonus = "bonus=#{item["bonusLists"].join(";")};"
        gems = "gems=#{item["tooltipParams"]["gem0"]}:#{item["tooltipParams"]["gem1"]}:#{item["tooltipParams"]["gem2"]};"
        id = "item=#{item["id"]};"
        "#{id}#{gems}#{enchants}#{bonus}#{set}"
      end

      def icon_image(image)
        image_tag("http://eu.media.blizzard.com/wow/icons/36/#{image}.jpg", class: "ui image")
      end
  end
end