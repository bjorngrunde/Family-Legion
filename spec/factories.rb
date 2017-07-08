FactoryGirl.define do
  factory :notification do
    user nil
    recipient_id 1
    action "MyString"
    notifiable_type "MyString"
    notifiable_id 1
  end

  factory :comment do

  end

  factory :event do
    name "Weekly Raid"
    body "Some interesting stuff here"
    difficulty "Heroic"
    start_date Date.today
    start_time "19:00"
    end_time "23:00"
    public true
    guild_event true
  end

  factory :dungeon do
    name "Court of Stars"
    dungeon_type "Dungeon"
  end

  factory :forum_comment do
    body "<div>Hejsan svejsan</div>"
  end

  factory :image_manager do

  end

  factory :forum_thread do
    title "A test thread"
    body "<div>A comment about current things and stuff</div>"
    is_locked false
    pinned false
  end

  factory :forum_category do
    title "Test Category"
    description "Have an ale and spill your guts"
    role  "default"
  end

  factory :forum_group do
    title "Test Group"
    role  "default"
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
