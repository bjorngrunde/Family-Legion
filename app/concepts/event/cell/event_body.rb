module Event::Cell
  class EventBody < Event::Cell::Master

    def user_icon user
      image_tag(user.profile.thumbnail, class: "ui avatar image")
    end

    def user_link user, notice
      return profile_link(user) if notice.nil? || notice.empty?
      "<span data-tooltip='#{notice}' class='#{user.profile.klass.sub('_', '-')}'> #{profile_link(user)}  <i class='warning sign icon'></i></span>"
    end
  end
end
