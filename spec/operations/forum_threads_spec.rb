require 'rails_helper'

RSpec.describe "Forum Thread Operation", type: :operation do

  before :each do
    @user = create_user
    @user.add_role :moderator
    @forum_group = create(:forum_group)
    @forum_category = create(:forum_category, forum_group_id: @forum_group.id)
  end

  it "should create a thread" do

    attrs = attributes_for(:forum_thread)

    result = Forum::Thread::Create.( { forum_thread: attrs, category: @forum_category.slug }, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted

    expect(result["model"].title).to eq("A test thread")
    expect(result["model"].body).to eq("<div>A comment about current things and stuff</div>")
    expect(result["model"].slug).to eq("a-test-thread")
    expect(result["model"].user).to eq(@user)
    expect(result["model"].forum_category).to eq(@forum_category)
    expect(result["model"].forum_group).to eq(@forum_group)
  end

  it "should update a thread" do

    forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)
    attrs = attributes_for(:forum_thread, title: "A very new title", body: "<div> Some amazing content </div>")

    result  = Forum::Thread::Update.({ forum_thread: attrs, id: forum_thread.id}, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted

    expect(result["model"].title).to eq("A very new title")
    expect(result["model"].body).to eq("<div> Some amazing content </div>")
    expect(result["model"].slug).to eq("a-very-new-title")
    expect(result["model"].user).to eq(@user)
    expect(result["model"].forum_category).to eq(@forum_category)
    expect(result["model"].forum_group).to eq(@forum_group)
  end

  it "should present a new model" do

    attrs = { group: @forum_group.slug, category: @forum_category.slug }

    result = Forum::Thread::New.( attrs, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to_not be_nil
    expect(result["model"].title).to be_nil
    expect(result["model"].body).to be_nil
  end

  it "should delete a forum thread" do

    forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)

    result = Forum::Thread::Delete.({ id: forum_thread.id}, "current_user" => @user )

    expect(result).to be_success
    expect(ForumThread.find_by(id: forum_thread.id).nil?).to eq(true)
  end

  it "should pin a thread" do
    forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)

    result = Forum::Thread::Pin.({ id: forum_thread.id })

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].pinned).to eq(true)
  end

  it "should lock a thread" do

    forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)

    result = Forum::Thread::Lock.({ id: forum_thread.id }, "current_user" => @user )

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].is_locked).to eq(true)
  end

  it "should move a thread" do

    forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)
    forum_group = create(:forum_group, title: "PVE", role: "default")
    forum_category = create(:forum_category, title: "Mythic", description: "Dungeons talk", forum_group_id: forum_group.id, role: "default")

    attrs = { forum_group_id: forum_group.id, forum_category_id: forum_category.id }

    result = Forum::Thread::Move.({ forum_thread: attrs, id: forum_thread.id}, "current_user" => @user )

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].forum_group).to eq(forum_group)
    expect(result["model"].forum_category).to eq(forum_category)
  end

  it "should copy a thread" do
    forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)
    forum_group = create(:forum_group, title: "PVE", role: "default")
    forum_category = create(:forum_category, title: "Mythic", description: "Dungeons talk", forum_group_id: forum_group.id, role: "default")

    attrs = { forum_group_id: forum_group.id, forum_category_id: forum_category.id }

    result = Forum::Thread::Copy.({ forum_thread: attrs, id: forum_thread.id }, "current_user" => @user )

    expect(result).to be_success
    expect(result["model"]).to be_persisted

    expect(result["model"].title).to eq("A test thread COPIED")
    expect(result["model"].body).to eq("<div>A comment about current things and stuff</div><br/> <small>Copied by <span class='paladin'>Bubbleoncd</span></small>")
    expect(result["model"].slug).to eq("a-test-thread-copied")
    expect(result["model"].forum_group).to eq(forum_group)
    expect(result["model"].forum_category).to eq(forum_category)
    expect(result["model"].user).to eq(@user)
  end

  it "should prohibit wrong params" do

    result = Forum::Thread::Create.({ forum_thread: {} }, "current_user" => @user)

    expect(result).to be_failure
    expect(result["model"]).to_not be_persisted

    expect(result["contract.default"].errors.messages[:title]).to eq(["can't be blank", "is too short (minimum is 5 characters)"])
    expect(result["contract.default"].errors.messages[:body]).to eq(["can't be blank"])
  end

  it "should be guarded by policy" do

    attrs = { forum_group_id: @forum_group.id, forum_category_id: @forum_category.id }
    forum_thread = create(:forum_thread, title: "something", forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)

    @user.remove_role :moderator

    result = Forum::Thread::Move.( { forum_thread: attrs, id: forum_thread.id }, "current_user" => @user)

    expect(result).to be_failure
    expect(result["result.policy.default"].failure?).to eq(true)

    user_attr = attributes_for(:user, username: "Bombka", email: "test@test.se")
    profile_attr = attributes_for(:profile)
    wrong_user = create_user(nil, user_attr, profile_attr)

    attrs = attributes_for(:forum_thread, title: "A very new title", body: "<div> Some amazing content </div>")

    result  = Forum::Thread::Update.({ forum_thread: attrs, id: forum_thread.id}, "current_user" => wrong_user)

    expect(result).to be_failure
    expect(result["result.policy.default"].failure?).to eq(true)
  end

end
