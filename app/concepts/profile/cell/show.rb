module Profile::Cell
  class Show < Familylegion::Cell::Master

    def background_image
      image_url("#{model_css_class}.jpg")
    end

    def avatar_image
      image_tag(model.profile.thumbnail, class: "ui circular image profile-thumbnail")
    end

    def character_items
      context[:items]
    end  
  end
end