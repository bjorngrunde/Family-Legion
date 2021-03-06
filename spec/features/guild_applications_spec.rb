require 'rails_helper'

RSpec.feature "GuildApplications", type: :feature do

  scenario "will register a new guild application" do

    visit(register_path)
    expect(page).to have_text("Apply for Family Legion")
    expect(page).to have_text("It might take several days to process your application, be patient and check your email from time to time.")

    fill_in "guild_application_first_name", :with => "Björn"
    fill_in "guild_application_last_name", :with => "Grunde"
    fill_in "guild_application_email", :with => "test@testing.se"
    fill_in "guild_application_username", :with => "Bombka"
    fill_in "guild_application_server", :with => "grim batol"
    fill_in "guild_application_spec", :with => "Arms"
    select "Warrior", from: "guild_application[klass]"
    click_button("Submit")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("Thank you for your application! We will email you within a few days")

    user = create_user
    login(user.email)

    visit(admin_guild_applications_path())
    click_link("Show")

    expect(page).to have_text("Status: Pending")
    expect(page).to have_text("Björn Grunde")
    expect(page).to have_text("grim batol")
    expect(page).to have_text("Warrior")
    expect(page).to have_text("Arms")

    #menu
    expect(page).to have_text("Edit")
    expect(page).to have_text("Delete")
    expect(page).to have_text("Reject")
    expect(page).to have_text("Approve")
  end

  scenario "should show validation errors", js: true do
    visit(register_path)
    expect(page).to have_text("Apply for Family Legion")
    expect(page).to have_text("It might take several days to process your application, be patient and check your email from time to time.")

    fill_in "guild_application_first_name", :with => ""
    fill_in "guild_application_last_name", :with => ""
    fill_in "guild_application_email", :with => ""
    fill_in "guild_application_username", :with => ""
    fill_in "guild_application_server", :with => ""
    fill_in "guild_application_spec", :with => ""
    click_button("Submit")

    expect(page).to have_text("Ohh my! Something went wrong with the request.")
    expect(page).to have_text("Email: Can't Be Blank")
    expect(page).to have_text("Username: Can't Be Blank")
    expect(page).to have_text("Server: Can't Be Blank")
    expect(page).to have_text("First name: Can't Be Blank")
    expect(page).to have_text("Last name: Can't Be Blank")
  end

  scenario "should be able to approve guild application", js: true do

    user = create_user
    login(user.email)

    guild_application = create(:guild_application)

    visit(admin_guild_application_path(id: guild_application.id))

    expect(page).to have_text("Reject")
    expect(page).to have_text("Approve")

    click_link("Approve")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("You changed the status to: Accepted")

  end

  scenario "should be able to decline guild application", js: true do

    user = create_user
    login(user.email)

    guild_application = create(:guild_application)

    visit(admin_guild_application_path(id: guild_application.id))

    expect(page).to have_text("Reject")
    expect(page).to have_text("Approve")

    click_link("Reject")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("You changed the status to: Declined")

  end

  scenario "should create a user", js: true do
    user = create_user
    login(user.email)

    guild_application = create(:guild_application)

    visit(admin_guild_application_path(id: guild_application.id))

    click_link("Approve")

    expect(page).to have_text("Create User")

    click_link("Create User")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("The user Bombka was created. Email with login information has been sent.")
  end

  scenario "should edit a guild application", js: true do
    user = create_user
    login(user.email)

    guild_application = create(:guild_application)

    visit(admin_guild_application_path(id: guild_application.id))

    expect(page).to have_text("Edit")

    click_link("Edit")

    fill_in "guild_application_first_name", :with => "Kalle"
    fill_in "guild_application_last_name", :with => "Jansson"
    fill_in "guild_application_server", :with => "Ragnaros"
    click_button("Save")

    expect(page).to have_text("Your changes has been saved")
    expect(page).to have_text("Kalle Jansson")
    expect(page).to have_text("Ragnaros")
  end
end
