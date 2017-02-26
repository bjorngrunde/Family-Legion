FactoryGirl.define do

  factory :guild_application do
    first_name  "John"
    last_name   "Doe"
    server      "Grim-Batol"
    username    "Bombka"
    klass       "warrior"
    email       "bjorngrunde@live.se"
  end

  factory :user do
    username    "Sprayandpray"
    email       "bjorngrunde@live.se"
    profile
  end

  factory :profile do
    first_name  "Björn"
    last_name   "Grunde"
    server      "grim batol"
    klass       "hunter"
    rank        1
    phone       "0728943923"
    rate        1
    spec        "Beast Mastery"
  end
end
