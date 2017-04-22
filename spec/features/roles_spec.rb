require 'rails_helper'

RSpec.feature "Roles", type: :feature do

  scenario "user should be able to create a role" do

    user = create_user

    login(user.email)

    visit(admin_users_path)
    click_link("#{user.id}")

    expect(page).to have_text("Roles")

    click_link("Roles")

    expect(page).to have_text("Admin")

    select "Member", :from => "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("Member")
    expect(page).to have_text("You have added the role member to Bubbleoncd")
  end

  scenario "should return error on multiple roles" do
    user = create_user

    login(user.email)

    visit(admin_users_path)
    click_link("#{user.id}")

    expect(page).to have_text("Roles")

    click_link("Roles")

    expect(page).to have_text("Admin")

    select "Member", :from => "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("Member")
    expect(page).to have_text("You have added the role member to Bubbleoncd")

    select "Member", :from => "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("Ohh my! Something went wrong with the request.")
    expect(page).to have_text("Base: The user already has this role!")
  end

  scenario "admin should not be able to edit developer" do
    user = create_user

    login(user.email)

    visit(admin_users_path)
    click_link("1") #id of seeded user, aka developer

    expect(page).to have_text("Roles")

    click_link("Roles")

    expect(page).to have_text("Admin")

    select "Member", :from => "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("Oh dear!")
    expect(page).to have_text("Something went wrong. You might not have the right authority to access that resource.")
  end
end
