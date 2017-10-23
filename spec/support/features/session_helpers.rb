module Features
  module SessionHelpers

    def login(email)
      visit("/")
      fill_in "email", :with => email
      fill_in "password", :with => ENV["USER_PW"]
      submit_form
    end

    def create_user(roles = nil, user_attr = nil, profile_attr = nil)
      
      user_attrs = user_attr || attributes_for(:user)
      
      profile_attrs = profile_attr || attributes_for(:profile)
      
      user = User.new(user_attrs)
      
      auth = Tyrant::Authenticatable.new(user)
      auth.digest!(ENV["USER_PW"])
      auth.confirmed!
      auth.sync
      
      user.save
      
      profile = Profile.new(profile_attrs)
      profile.user = user
      profile.save
      if roles.nil?
        user.add_role :admin
      else
        roles.each { |role| user.add_role role }
      end
      user
    end
  end
end
