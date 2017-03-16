user = User.new({username: "Sprayandpray", email: "bjorngrunde@live.se"})
auth = Tyrant::Authenticatable.new(user)
auth.digest!(ENV["USER_PW"])
auth.confirmed!
auth.sync
user.save
profile = Profile.new({ user_id: user.id, first_name: "Björn", last_name: "Grunde", klass: "hunter", rank: 1, server: "grim batol", spec: "Beast Mastery"})
profile.save