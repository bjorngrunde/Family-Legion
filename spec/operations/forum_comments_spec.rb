require 'rails_helper'

RSpec.describe "Forum Comment Operation", type: :operation do

  before :each do
    @user = create_user
    @user.add_role :moderator
    @forum_group = create(:forum_group)
    @forum_category = create(:forum_category, forum_group_id: @forum_group.id)
    @forum_thread = create(:forum_thread, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, user_id: @user.id)
  end

  it "should create a comment" do

    attrs = attributes_for(:forum_comment, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, forum_thread_id: @forum_thread.id, user_id: @user.id)

    result = Forum::Comment::Create.(attrs, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to be_persisted

    expect(result["model"].body).to eq("<div>Hejsan svejsan</div>")
    expect(result["model"].user).to eq(@user)
    expect(result["model"].forum_group).to eq(@forum_group)
    expect(result["model"].forum_category).to eq(@forum_category)
    expect(result["model"].forum_thread).to eq(@forum_thread)
  end

  it "should update delete a comment" do
    forum_comment = create(:forum_comment, forum_group_id: @forum_group.id, forum_category_id: @forum_category.id, forum_thread_id: @forum_thread.id, user_id: @user.id)

    result = Forum::Comment::Delete.({ id: forum_comment.id }, "current_user" => @user)

    expect(result).to be_success
    expect(result["model"]).to_not be_persisted

    expect(ForumComment.find_by(id: forum_comment.id)).to eq(nil)
  end
end
