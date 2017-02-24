module Familylegion::Cell
  class Navigation < Trailblazer::Cell
    
    def current_user
      context[:current_user]
    end
    
    def avatar_image
      image_tag(current_user.profile.thumbnail, class:"ui avatar image")
    end
  end
end