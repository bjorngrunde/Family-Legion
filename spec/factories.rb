FactoryGirl.define do
  factory :image_manager do
    
  end
  factory :forum_thread do
    
  end
  factory :forum_category do
    
  end
  factory :forum_group do
    
  end

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
    username    "Bubbleoncd"
    email       "kalle@live.se"
    profile
  end

  factory :profile do
    first_name  "Björn"
    last_name   "Grunde"
    server      "grim batol"
    klass       "paladin"
    rank        1
    phone       "0728943923"
    rate        1
    spec        "Holy"
    thumbnail   "http://render-eu.worldofwarcraft.com/character/grim-batol/249/146873337-avatar.jpg"
    avatar      "http://render-eu.worldofwarcraft.com/character/grim-batol/249/146873337-profilemain.jpg"
  end

  factory :alt do
    username  "Nublol"
    server    "Grim Batol"
    klass     "druid"
    thumbnail "http://render-eu.worldofwarcraft.com/character/grim-batol/202/113106634-avatar.jpg"
  end

  factory :role do
    name "admin"
  end
end
