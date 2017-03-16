module Features
  module SessionHelpers
    
    def login(email, password)
      visit("/")
      fill_in "email", :with => email
      fill_in "password", :with => password
      submit_form
    end

    def create_user(role = nil)
      attrs = attributes_for(:user) do |user|
        user.store(:profile, attributes_for(:profile))
      end

      user = User::CreateUserFromGuildApplication.({ user: attrs})
      if role.nil?
        user["model"].add_role :admin
      else
        user["model"].add_role role
      end
      user
    end
  end
end