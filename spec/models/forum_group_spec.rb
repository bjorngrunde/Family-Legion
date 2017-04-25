require 'rails_helper'

RSpec.describe ForumGroup, type: :model do

  it "should create a forum_group" do
    attrs = attributes_for(:forum_group, title: "test", role: "default")

    forum_group = ForumGroup.create(attrs)

    expect(forum_group.title).to eq("test")
    expect(forum_group.role).to eq("default")
    expect(forum_group.slug).to eq("test")
  end

  it "should be able to update forum_group" do

    attrs = attributes_for(:forum_group, title: "test group", role: "default")

    forum_group = ForumGroup.create(attrs)

    expect(forum_group.title).to eq("test group")
    expect(forum_group.role).to eq("default")
    expect(forum_group.slug).to eq("test-group")

    forum_group.update_attributes({ title: "New Test Group", role: "admin"})

    expect(forum_group.title).to eq("New Test Group")
    expect(forum_group.role).to eq("admin")
    expect(forum_group.slug).to eq("new-test-group")
  end
end
