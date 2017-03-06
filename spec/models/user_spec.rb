require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should create a user" do

    attrs = attributes_for(:user) do |user|
        user.store(:profile, attributes_for(:profile))
      end

    result = User::CreateUserFromGuildApplication.({ user: attrs})

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].username).to eq("Sprayandpray")
    expect(result["model"].profile).to be_persisted
    expect(result["model"].profile.klass).to eq("hunter") 
  end

  it "it prohibits empty user params" do
    result = User::CreateUserFromGuildApplication.({ })

    expect(result).to be_failure
    expect(result["model"]).to_not be_persisted

  end

  it "can update a user" do
    attrs = attributes_for(:user) do |user|
        user.store(:profile, attributes_for(:profile))
      end

    result = User::CreateUserFromGuildApplication.({ user: attrs})
    
    user = result["model"]
    user.profile.rank = 5
    user.email = "test@test.se"

    result2 = User::Update.({ id: user.id,  user: { email: user.email, profile: { rank: user.profile.rank } } })

    expect(result2).to be_success
    expect(result2["model"]).to be_persisted
    expect(result2["model"].email).to eq("test@test.se")
    expect(result2["model"].profile).to be_persisted
    expect(result2["model"].profile.rank).to eq("guild_master")
  end
end
