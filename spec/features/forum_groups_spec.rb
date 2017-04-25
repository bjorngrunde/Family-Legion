require 'rails_helper'

RSpec.feature "ForumGroups", type: :feature do

  before :each do
    roles = [:moderator, :raid_leader, :member, :raider, :admin]
    user = create_user roles
    login(user.email)
  end

  scenario "should create forum_group", js: true do

    visit(forum_overview_path)
    find(".settings").click
    find(".item.new.forum.group").click

    within(".ui.small.new.group.modal") do
      expect(page).to have_text("New Forum Group")

      wait_for_ajax

      fill_in :title, with: "PVE"
      find(".ui.dropdown.selection").click
      find(".item", text: "Member").click

      click_button("submit")
    end

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("Group successfully created")

    expect(page).to have_text("PVE")
  end

  scenario "it should show negative flash if empty params", js: true do
    visit(forum_overview_path)
    find(".settings.icon").click
    find(".item.new.forum.group").click

    within(".ui.small.new.group.modal") do
      expect(page).to have_text("New Forum Group")

      click_button("submit")
    end

    expect(page).to have_text("Ohh my! Something went wrong with the request.")
  end

  scenario "should delete group", js: true do

    visit(forum_overview_path)
    find(".settings.icon").click
    find(".item.edit.forum.group").click

    within(".ui.small.edit.group.modal") do
      expect(page).to have_text("Edit a group")

      find(".ui.dropdown.selection").click
      find(".item", text: "General").click

      wait_for_ajax

      expect(page).to have_text("Title")
      expect(page).to have_text("Limit Access")

      within(".ui.top.attached.tabular.menu") do
        find("div", text: "Delete").click
      end

      expect(page).to have_text("Delete Group")
      expect(page).to have_text("If you choose to delete a group or category, all current categories/threads that belongs to that resource will be moved to the \"Uncategorized\" group and threads will be moved to the \"Uncategorized Threads\" category. These resources will only be accessible by moderators and it is up to you to move these to other areas of the forum.")

      click_link("Delete Group")
    end

    expect(page).to have_text("The object has been permamently deleted")
    expect(page).to have_text("Uncategorized Categories")
  end
end
