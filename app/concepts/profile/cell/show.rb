module Profile::Cell
  class Show < Familylegion::Cell::Master

    def background_image
      image_url("#{model_css_class}.jpg")
    end

    def avatar_image
      image_tag(model.profile.thumbnail, class: "ui circular image profile-thumbnail")
    end

    def icon_image(image, quality)
      image_tag("https://render-us.worldofwarcraft.com/icons/36/#{image}.jpg", class: "ui image item-border-#{quality}")
    end
  end
end
