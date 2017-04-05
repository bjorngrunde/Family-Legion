module Features
  module SessionHelpers
    
    def login(email)
      visit("/")
      fill_in "email", :with => email
      fill_in "password", :with => ENV["USER_PW"]
      submit_form
    end

    def create_user(role = nil)
      user_attrs = attributes_for :user
      profile_attrs = attributes_for :profile
      user = User.new(user_attrs)
      auth = Tyrant::Authenticatable.new(user)
      auth.digest!(ENV["USER_PW"])
      auth.confirmed!
      auth.sync
      user.save
      profile = Profile.new(profile_attrs)
      profile.user = user
      profile.save
      if role.nil?
        user.add_role :admin
      else
        user.add_role role
      end
      user
    end
  end
end