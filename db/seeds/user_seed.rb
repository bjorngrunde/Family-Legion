user = User.new({username: "Sprayandpray", email: "bjorngrunde@live.se"})
auth = Tyrant::Authenticatable.new(user)
auth.digest!(ENV["USER_PW"])
auth.confirmed!
auth.sync
user.save
user.add_role :admin
profile = Profile.new({ user_id: user.id, first_name: "Björn", last_name: "Grunde", klass: "hunter", rank: 1, server: "grim batol", spec: "Beast Mastery", thumbnail: "http://render-eu.worldofwarcraft.com/character/grim-batol/249/146873337-avatar.jpg", avatar: "http://render-eu.worldofwarcraft.com/character/grim-batol/249/146873337-profilemain.jpg"})
profile.save