require 'rails_helper'

RSpec.describe "Forum Category Operation", type: :operation do

  before :each do
    @user = create_user
    @user.add_role :moderator
    @forum_group = create(:forum_group)
  end

  it "should create a category" do
    attrs = attributes_for(:forum_category, forum_group_id: @forum_group.id)

    result = Forum::Category::Create.(attrs, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted

    expect(result["model"].title).to eq("Test Category")
    expect(result["model"].description).to eq("Have an ale and spill your guts")
    expect(result["model"].role).to eq("default")
    expect(result["model"].slug).to eq("test-category")

    expect(result["model"].forum_group.title).to eq("Test Group")
  end

  it "should update an category" do

    forum_category = create(:forum_category, forum_group_id: @forum_group.id)

    attrs = attributes_for(:forum_category, title: "test title", description: "test description", role: "raider", id: forum_category.id)

    result = Forum::Category::Update.(attrs, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted

    expect(result["model"].title).to eq("test title")
    expect(result["model"].description).to eq("test description")
    expect(result["model"].role).to eq("raider")
    expect(result["model"].slug).to eq("test-title")
  end

  it "should validate params" do

    result = Forum::Category::Create.({}, "current_user" => @user)

    expect(result).to be_failure
    expect(result["model"]).to_not be_persisted

    expect(result["contract.default"].errors.any?).to eq(true)
    expect(result["contract.default"].errors.messages[:title]).to eq(["can't be blank", "is too short (minimum is 5 characters)"])
    expect(result["contract.default"].errors.messages[:description]).to eq(["can't be blank"])
    expect(result["contract.default"].errors.messages[:role]).to eq(["can't be blank"])
    expect(result["contract.default"].errors.messages[:forum_group_id]).to eq(["can't be blank"])
  end

  it "should delete an category" do

    forum_category = create(:forum_category, forum_group_id: @forum_group.id)

    result = Forum::Category::Delete.({ id: forum_category.id }, "current_user" => @user)

    expect(result).to be_success
    expect(ForumCategory.find_by(id: forum_category.id)).to be_nil
  end

  it "should create uncategorized categories if category has threads when deleted" do

    forum_category = create(:forum_category, forum_group_id: @forum_group.id)
    forum_thread = create(:forum_thread, forum_category_id: forum_category.id, forum_group_id: @forum_group.id, user_id: @user.id)

    result = Forum::Category::Delete.({ id: forum_category.id }, "current_user" => @user)

    expect(result).to be_success
    expect(ForumCategory.find_by(id: forum_category.id)).to be_nil

    new_category = ForumCategory.find_by(slug: "uncategorized-threads")

    expect(new_category.forum_group.title).to eq("Uncategorized Categories")
    expect(new_category.forum_threads.first.title).to eq("A test thread")
    expect(new_category.forum_threads.first.user).to eq(@user)
  end

  it "policy will fail if user is not moderator" do

    attrs = attributes_for(:forum_category)
    @user.remove_role :moderator

    result = Forum::Category::Create.(attrs, "current_user" => @user)

    expect(result).to be_failure
    expect(result["result.policy.default"].failure?).to eq(true)
  end
end
