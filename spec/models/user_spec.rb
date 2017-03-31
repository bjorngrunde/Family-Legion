require 'rails_helper'

RSpec.describe User, type: :model do

  it "should create a user" do

    attrs = attributes_for(:user)
    attrrs2 = attributes_for(:profile)


    user = User.create(attrs)
    profile = Profile.new(attrrs2)
    profile.user = user
    profile.save

    expect(user).to be_persisted
    expect(user.username).to eq("Bubbleoncd")
    expect(user.profile).to be_persisted
    expect(user.profile.klass).to eq("paladin")
  end

  it "can update a user" do
    attrs = attributes_for(:user)
    attrrs2 = attributes_for(:profile)


    user = User.create(attrs)
    profile = Profile.new(attrrs2)
    profile.user = user
    profile.save

    user.profile.rank = 5
    user.email = "test@test.se"

    user.save

    expect(user).to be_persisted
    expect(user.email).to eq("test@test.se")
    expect(user.profile).to be_persisted
    expect(user.profile.rank).to eq("guild_master")
  end
end
