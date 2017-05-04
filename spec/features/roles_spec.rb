require 'rails_helper'

RSpec.feature "Roles", type: :feature do

  before :each do
    @user = create_user
    login(@user.email)
  end

  scenario "user should be able to create a role", js: true do

    visit(admin_users_path)
    click_link("#{@user.id}")

    expect(page).to have_text("Roles")

    click_link("Roles")

    expect(page).to have_text("Admin")

    select "Member", :from => "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("Member")
    expect(page).to have_text("You have added the role Member to Bubbleoncd")
  end

  scenario "should return error on uniq roles", js: true do

    visit(admin_users_path)
    click_link("#{@user.id}")

    expect(page).to have_text("Roles")

    click_link("Roles")

    expect(page).to have_text("Admin")

    @user.add_role :member

    select "Member", from: "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("The user already has this role!")
  end

  scenario "admin should not be able to edit developer", js: true do

    visit(admin_users_path)
    find("a", id: "1", text: "Show").click #id of seeded user, aka developer

    expect(page).to have_text("Roles")

    click_link("Roles")

    expect(page).to have_text("Admin")

    select "Member", :from => "role_contract_new[roles]"
    click_button("Add role")

    expect(page).to have_text("Oh dear!")
    expect(page).to have_text("Something went wrong. You might not have the right authority to access that resource.")
  end
end
