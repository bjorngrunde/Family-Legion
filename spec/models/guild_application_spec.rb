require 'rails_helper'

RSpec.describe GuildApplication, type: :model do

  it "should create a guild application" do

    result = GuildApplication::Create.({guild_application: {first_name: "jon", last_name: "doe", username: "Bombka", email: "bjorngrunde@live.se", server: "Grim-Batol"}})

    expect(result).to be_success
    expect(result["model"]).to be_persisted
  end

end
