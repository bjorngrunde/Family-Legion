module Profile::Cell
  class Avatar < Profile::Cell::Show
    
    def item_link(item, type)
      if item.nil?
        image = image_tag("#{type.to_s}.png", class: "ui image", width: "36", height: "36")
        return link_to("#{image}","#", data: { tooltip: "Not equiped. True n00b!", position: "left center"}).html_safe
      end
      image = icon_image(item["icon"], item["quality"])

      link_to("#{image}", "#", rel: link_data_types(item)).html_safe
    end

    private
    def link_data_types(item)
      #Lets split everything up for readabiltiy..ish
      set = "pcs=#{item["tooltipParams"]["set"].join(":")};" unless item["tooltipParams"]["set"].nil?
      enchants = "ench=#{item["tooltipParams"]["enchant"]};"
      bonus = "bonus=#{item["bonusLists"].join(":")};"
      gems = "gems=#{item["tooltipParams"]["gem0"]}:#{item["tooltipParams"]["gem1"]}:#{item["tooltipParams"]["gem2"]};"
      id = "item=#{item["id"]};"
      "#{id}#{gems}#{enchants}#{bonus}#{set}"
    end
  end
end