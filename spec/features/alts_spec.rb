require 'rails_helper'

RSpec.feature "Alts", type: :feature do
  
  scenario "should create an alt" do
    result = create_user

    login(result["model"].email, result["generated_password"])

    visit(user_setting_control_panel_path(username: result["model"].username))
    expect(page).to have_text("Create")
    click_link("Create")

    fill_in "alt[username]" , :with => "Bertius"
    fill_in "alt[server]", :with => "Grim Batol"
    select "Warrior", :from => "alt[klass]"

    click_button("Save")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("You have created an alt. Good job!")
    expect(page).to have_text("Bertius")
    expect(page).to have_text("Grim Batol")
  end

  scenario "should raise errors when creating alt" do

    result = create_user
    login(result["model"].email, result["generated_password"])

    visit(user_setting_control_panel_path(username: result["model"].username))
    expect(page).to have_text("Create")
    click_link("Create")

    click_button("Save")

    expect(page).to have_text("Ohh my! This does not look right.")
    expect(page).to have_text("Username: Can't Be Blank")
    expect(page).to have_text("Server: Can't Be Blank")

    visit(new_user_setting_alt_path(username: result["model"].username)) #TODO: Fix a reload() method later
    
    fill_in "alt[username]" , :with => "Bertius"
    fill_in "alt[server]", :with => "grom botol"
    select "Warrior", :from => "alt[klass]"

    click_button("Save")

    expect(page).to have_text("Username: The character you tried to add does not exist! Make sure the name and realm is correct.")

    fill_in "alt[username]" , :with => "Bertius"
    fill_in "alt[server]", :with => "Grim Batol"
    select "Warrior", :from => "alt[klass]"

    click_button("Save")

    visit(new_user_setting_alt_path(username: result["model"].username))

    fill_in "alt[username]" , :with => "Bertius"
    fill_in "alt[server]", :with => "Grim Batol"
    select "Warrior", :from => "alt[klass]"

    click_button("Save")

    expect(page).to have_text("Username: The resource you tried to save already exists!")
  end

  scenario "should update alt" do
    result = create_user
    login(result["model"].email, result["generated_password"])

    alt = create(:alt, user_id: result["model"].id)

    visit(edit_user_setting_alt_path(username: result["model"].username, id: alt.id))

    select "Druid", :from => "alt[klass]"

    click_button("Save")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("Your changes has been saved")
  end

  scenario "should change alt to main character" do
    result = create_user
    login(result["model"].email, result["generated_password"])

    alt = create :alt, user_id: result["model"].id

    visit(user_setting_alts_path(username: result["model"].username))

    click_link("change-main")

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("You changed main character from Sprayandpray to Nublol")
  end

  scenario "can delete alt", js: true do
    result = create_user
    login(result["model"].email, result["generated_password"])

    alt = create :alt, user_id: result["model"].id

    visit(user_setting_alts_path(username: result["model"].username))

    click_link("destroy-alt")

    page.driver.browser.switch_to.alert.accept
    expect(alt).to eq(nil)
  end
end