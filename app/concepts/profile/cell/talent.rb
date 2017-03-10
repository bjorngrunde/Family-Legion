module Profile::Cell
  class Talent < Profile::Cell::Show

    def talent_links()
      talent_map = []
      talents = context[:talents][0].to_h
      talents["talents"].each do |talent|
        image = icon_image(talent["spell"]["icon"], 1)

        talent_map << link_to("#{image}", "#", rel: talent_data_types(talent["spell"]))
      end
      talent_map
    end

    def talent_data_types(spell)
      "spell=#{spell["id"]};"
    end

  end
end