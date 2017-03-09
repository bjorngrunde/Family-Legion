FactoryGirl.define do

  factory :guild_application do
    first_name  "John"
    last_name   "Doe"
    server      "Grim Batol"
    username    "Bombka"
    klass       "warrior"
    email       "test@test.se"
    status      1
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

  factory :alt do
    username  "Nublol"
    server    "Grim Batol"
    klass     "demon_hunter"
    thumbnail "http://render-eu.worldofwarcraft.com/character/grim-batol/202/113106634-avatar.jpg"
  end
end
