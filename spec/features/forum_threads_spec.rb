require 'rails_helper'

RSpec.feature "ForumThreads", type: :feature do

  #Mostly testing stuff that requires js, operations tests covers everything else

  before :each do
    roles = [:moderator, :raid_leader, :member, :raider, :admin]
    @user = create_user roles
    login(@user.email)
  end

  scenario "should create thread", js: true do

    visit(forum_overview_path)
    click_link("The Tavern")

    expect(page).to have_text("New thread")

    click_link("New thread")

    within(".ui.equal.width.inverted.form") do

      fill_in :forum_thread_title, with: "An amazing thread about stuff"
      fill_in_trix_editor("<div>Really cool stuff here <a href='http://facebook.com'>link</a></div>".html_safe)

      submit_form
    end

    expect(page).to have_text("An amazing thread about stuff")
    expect(page).to have_text("Really cool stuff here link")

    click_link("The Tavern")

    expect(page).to have_text("An amazing thread about stuff")

    click_link("An amazing thread about stuff")
  end

  scenario "should pin a thread", js: true do
    forum_group = create(:forum_group)
    forum_category = create(:forum_category, title: "Amazing Category", forum_group_id: forum_group.id)
    forum_thread = create(:forum_thread, title: "Amazing Title", body: "<div>Some content</div>", user_id: @user.id, forum_group_id: forum_group.id, forum_category_id: forum_category.id)

    visit(forum_overview_path)
    click_link("Amazing Category")

    expect(page).to have_text("Amazing Title")
    click_link("Amazing Title")
    find(".settings").click
    click_link("Pin")

    expect(page).to have_text("This thread is pinned")
  end

  scenario "should lock a thread", js: true do
    forum_group = create(:forum_group)
    forum_category = create(:forum_category, title: "Amazing Category", forum_group_id: forum_group.id)
    forum_thread = create(:forum_thread, title: "Amazing Title", body: "<div>Some content</div>", user_id: @user.id, forum_group_id: forum_group.id, forum_category_id: forum_category.id)

    visit(forum_overview_path)
    click_link("Amazing Category")

    expect(page).to have_text("Amazing Title")
    click_link("Amazing Title")
    find(".settings.icon").click

    click_link("Lock")

    expect(page).to have_text("This thread is locked")
  end

  scenario "should copy a thread", js: true do
    forum_group = create(:forum_group)
    forum_category = create(:forum_category, title: "Amazing Category", forum_group_id: forum_group.id)
    forum_thread = create(:forum_thread, title: "Amazing Title", body: "<div>Some content</div>", user_id: @user.id, forum_group_id: forum_group.id, forum_category_id: forum_category.id)

    visit(forum_overview_path)
    click_link("Amazing Category")

    expect(page).to have_text("Amazing Title")
    click_link("Amazing Title")
    find(".settings.icon").click
    find(".copy-thread").click

    within(".ui.small.react.thread.modal") do
      find(".ui.search.dropdown.selection").click
      find(".item", text: "Amazing Category").click

      submit_form
    end

    expect(page).to have_text("Amazing Title COPIED")
    expect(page).to have_text("Copied by Bubbleoncd")
  end

  scenario "should move a thread", js: true do
    forum_group = create(:forum_group)
    forum_category = create(:forum_category, title: "Amazing Category", forum_group_id: forum_group.id)
    forum_thread = create(:forum_thread, title: "Amazing Title", body: "<div>Some content</div>", user_id: @user.id, forum_group_id: forum_group.id, forum_category_id: forum_category.id)

    visit(forum_overview_path)
    click_link("Amazing Category")

    expect(page).to have_text("Amazing Title")
    click_link("Amazing Title")
    find(".settings.icon").click
    find(".move-thread").click

    within(".ui.small.react.thread.modal") do
      find(".ui.search.dropdown.selection").click
      find(".item", text: "The Tavern").click

      submit_form
    end

    expect(page).to have_text("The Tavern") #Check the breadcrumb link
    click_link("The Tavern")
    expect(page).to have_text("Amazing Title")
    click_link("Amazing Title")
  end

  scenario "should delete a thread" do
    forum_group = create(:forum_group)
    forum_category = create(:forum_category, title: "Amazing Category", forum_group_id: forum_group.id)
    forum_thread = create(:forum_thread, title: "Amazing Title", body: "<div>Some content</div>", user_id: @user.id, forum_group_id: forum_group.id, forum_category_id: forum_category.id)

    visit(forum_overview_path)
    click_link("Amazing Category")

    expect(page).to have_text("Amazing Title")
    click_link("Amazing Title")
    find(".settings.icon").click
    find(".delete-thread").click

    expect(page).to have_text("Are you sure?")
    expect(page).to have_text("Deleting a thread will also delete all comments associated with it.")

    within(".ui.alert.basic.modal") do
      find(".ui.green.ok.inverted.button").click
    end

    expect(page).to have_text("The thread was successfully destroyed")
    expect { ForumThread.find(forum_thread.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
