require 'rails_helper'

RSpec.feature "ForumCategories", type: :feature do

  before :each do
    roles = [:moderator, :raid_leader, :member, :raider, :admin]
    @user = create_user roles
    login(@user.email)
  end

  scenario "should be able to create a category", js: true do

    visit(forum_overview_path)
    find(".settings").click
    find(".item.new.forum.category").click

    within(".ui.small.new.category.modal") do

      expect(page).to have_text("New Forum Category")

      wait_for_ajax

      fill_in :title, with: "Guild News"
      fill_in :description, with: "Guild news are archived here"

      within(".field.role-select") do
        find(".ui.dropdown.selection").click
        find(".item", text: "Member").click
      end

      within(".field.group-select") do
        find(".ui.dropdown.selection").click
        find(".item", text: "General").click
      end

      submit_form
    end

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("Category successfully created")

    expect(page).to have_text("General")
    expect(page).to have_text("Guild News")
    expect(page).to have_text("Guild news are archived here")

    click_link("Guild News")

    expect(page).to have_text("New thread")

    within(".ui.large.breadcrumb") do
      click_link("Forum")
    end

    @user.remove_role :member
    @user.reload

    page_reload

    expect(page).to_not have_text("Guild News")
  end

  scenario "should be able to update category", js: true do

    forum_category = create(:forum_category, forum_group_id: 1)

    visit(forum_overview_path)
    find(".settings").click
    find(".item.edit.forum.category").click

    within(".ui.small.edit.category.modal") do

      find(".ui.dropdown.selection").click
      find(".item", text: "Test Category").click

      wait_for_ajax

      fill_in :title, with: "Guild News"
      fill_in :description, with: "Guild News are archived here"

      within(".field.role-select") do
        find(".ui.dropdown.selection").click
        find(".item", text: "Member").click
      end

      submit_form
    end

    expect(page).to have_text("Oh Yeah!")
    expect(page).to have_text("You successfully updated a forum category")

    expect(page).to have_text("Guild News")
    expect(page).to have_text("Guild News are archived here")
  end

  scenario "should delete a category", js: true do

    forum_category = create(:forum_category, forum_group_id: 1)

    visit(forum_overview_path)

    expect(page).to have_text("Test Category")

    find(".settings").click
    find(".item.edit.forum.category").click

    within(".ui.small.edit.category.modal") do

      find(".ui.dropdown.selection").click
      find(".item", text: "Test Category").click

      within(".ui.top.attached.tabular.menu") do

        find("div", class: "item", text: "Delete").click
      end

      expect(page).to have_text("If you choose to delete a group or category, all current categories/threads that belongs to that resource will be moved to the \"Uncategorized\" group and threads will be moved to the \"Uncategorized Threads\" category. These resources will only be accessible by moderators and it is up to you to move these to other areas of the forum.")

      click_link("Delete Category")
    end

    expect(page).to_not have_text("Test Category")
  end
end
