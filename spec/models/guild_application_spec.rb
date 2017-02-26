require 'rails_helper'

RSpec.describe GuildApplication, type: :model do

  it "should create a guild application" do

    attrs = attributes_for(:guild_application)

    result = GuildApplication::Create.({guild_application: attrs})

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].first_name).to eq("John")
  end

  it "prohibits empty params" do
    result = GuildApplication::Create.({})

    expect(result).to be_failure
    expect(result["model"]).not_to be_persisted
  end

  it "should update status to accepted" do
    application = create(:guild_application)
    application.status = "accepted"

    result = GuildApplication::Update.({id: application.id, guild_application: {status: application.status}})

    expect(result).to be_success
    expect(result["model"]).to be_persisted
    expect(result["model"].status).to eq(application.status)
  end

  it "should destroy an application" do

    application = create(:guild_application)

    result = GuildApplication::Destroy.({id: application.id})

    expect(result).to be_success
    expect { GuildApplication.find(application.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
