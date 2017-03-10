module Features
  module SessionHelpers
    
    def login(email, password)
      visit("/")
      fill_in "email", :with => email
      fill_in "password", :with => password
      submit_form
    end

    def create_user
      attrs = attributes_for(:user) do |user|
        user.store(:profile, attributes_for(:profile))
      end

      User::CreateUserFromGuildApplication.({ user: attrs})
    end

  end
end