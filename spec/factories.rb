FactoryGirl.define do
  factory :profile do
    
  end
  factory :user do
    
  end

  factory :guild_application do
    first_name  "John"
    last_name   "Doe"
    server      "Grim-Batol"
    username    "Bombka"
    klass       "warrior"
    email       "bjorngrunde@live.se"
  end
end
