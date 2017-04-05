require 'rails_helper'

RSpec.feature "Users", type: :feature do

  scenario "User can change password" do

    new_password = "taskmört1337"

    user = create_user

    login(user.email)

    visit(user_setting_change_password_path(username: user.username))

    fill_in "user_old_password", :with => ENV["USER_PW"]
    fill_in "user_new_password", :with => new_password
    fill_in "user_confirm_new_password", :with => new_password
    click_button("Save")

    expect(page).to have_text("Oh Yeah")
    expect(page).to have_text("You have changed your password! Good Boy!")
  end


  scenario "Should show validation errors when changing password" do

    new_password = "taskmört1337"

    user = create_user

    login(user.email)

    visit(user_setting_change_password_path(username: user.username))

    fill_in "user_old_password", :with => "crappy string"
    fill_in "user_new_password", :with => ""
    fill_in "user_confirm_new_password", :with => ""
    click_button("Save")

    expect(page).to have_text("Ohh my! This does not look right")
    expect(page).to have_text("Old password: Wrong password")
    expect(page).to have_text("Confirm new password: Can't Be Blank")
    expect(page).to have_text("New password: Can't Be Blank")


    fill_in "user_old_password", :with => ENV["USER_PW"]
    fill_in "user_new_password", :with => new_password
    fill_in "user_confirm_new_password", :with => "crappy string"
    click_button("Save")

    expect(page).to have_text("Ohh my! This does not look right.")
    expect(page).to have_text("New password: Passwords dont match")

  end
end
