require 'rails_helper'

RSpec.feature "ForumComments", type: :feature do

  #Mostly testing stuff that requires js, operations tests covers everything else

  before :each do
    roles = [:moderator, :raid_leader, :member, :raider, :admin]
    @user = create_user roles
    @forum_group = create(:forum_group)
    @forum_category = create(:forum_category, forum_group_id: @forum_group.id)
    @forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)

    login(@user.email)
  end

  scenario "should create a comment", js: true do

    visit(forum_overview_path)

    click_link("Test Category")
    click_link("A test thread")

    within(".ui.equal.width.inverted.form") do
      fill_in_trix_editor("<div> Hej din fubick!</div>")

      submit_form
    end

    expect(page).to have_text("Hej din fubick!")
  end

  scenario "should quote a thread", js: true do

    visit(forum_overview_path)

    click_link("Test Category")
    click_link("A test thread")

    click_link("Quote")

    within(".ui.equal.width.inverted.form") do
      submit_form
    end

    expect(page).to have_text("A comment about current things and stuff@Bubbleoncd")
  end

  scenario "should delete a comment", js: true do
    forum_comment = create(:forum_comment, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, forum_thread_id: @forum_thread.id, user_id: @user.id )

    visit(forum_overview_path)

    click_link("Test Category")
    click_link("A test thread")

    expect(page).to have_text("Hejsan svejsan")

    find(".trash.icon").click

    expect(page).to_not have_text("Hejsan svejsan")

    expect(ForumComment.find_by(id: forum_comment.id)).to eq(nil)
  end
end
