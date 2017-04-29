require 'rails_helper'

RSpec.describe "Forum Group Operation", type: :operation do

  before :each do
    @user = create_user
    @user.add_role :moderator
  end

  it "should create a forum_group" do

    attrs = attributes_for(:forum_group, title: "Amazing test title", role: "default")

    result = Forum::Group::Create.(attrs, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].title).to eq("Amazing test title")
    expect(result["model"].role).to eq("default")
    expect(result["model"].slug).to eq("amazing-test-title")
  end

  it "should prohibit empty params" do

    result = Forum::Group::Create.({}, "current_user" => @user)

    expect(result).to_not be_success
    expect(result["model"]).to_not be_persisted

    expect(result["contract.default"].errors.any?).to eq(true)
    expect(result["contract.default"].errors.messages[:role]).to eq(["can't be blank"])
    expect(result["contract.default"].errors.messages[:title]).to eq(["can't be blank"])
  end

  it "policy should return failure if user is not a moderator" do

    @user.remove_role :moderator
    attrs = attributes_for(:forum_group, title: "Amazing test title", role: "default")

    result = Forum::Group::Create.(attrs, "current_user" => @user)

    expect(result).to_not be_success
    expect(result["model"]).to_not be_persisted
    expect(result["result.policy.default"].failure?).to eq(true)
  end

  it "should update a forum group" do

    forum_group = create(:forum_group, title: "another awesome title", role: "member")
    attrs = attributes_for(:forum_group, title: "New test title", role: "raider", id: forum_group.id )

    result = Forum::Group::Update.(attrs , "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].title).to eq("New test title")
    expect(result["model"].role).to eq("raider")
    expect(result["model"].slug).to eq("new-test-title")
  end

  it "should delete a forum group" do

    forum_group = create(:forum_group, title: "test group", role: "default")

    result = Forum::Group::Delete.({id: forum_group.id}, "current_user" => @user)

    expect(result).to be_success
    expect(ForumGroup.find_by(id: forum_group.id)).to be_nil
  end

  it "should create uncategorized group if it has categories when deleted" do

    forum_group = create(:forum_group)
    forum_category = create(:forum_category, title: "amazing category", description: "so much testing", role: "default", forum_group_id: forum_group.id)

    result = Forum::Group::Delete.({id: forum_group.id}, "current_user" => @user)

    expect(result).to be_success
    expect(ForumGroup.find_by(id: forum_group.id)).to be_nil

    new_group = ForumGroup.find_by(slug: "uncategorized-categories")

    expect(new_group.forum_categories.first.title).to eq("amazing category")
    expect(new_group.forum_categories.first.description).to eq("so much testing")
    expect(new_group.forum_categories.first.role).to eq("default")
  end
end
