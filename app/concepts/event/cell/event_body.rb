module Event::Cell
  class EventBody < Event::Cell::Master

    def user_icon user
      "#{image_tag(user.profile.thumbnail, class:"ui avatar image")}"
    end

  end
end
