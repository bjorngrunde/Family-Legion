# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Should be extracted to its own seed file later on
played = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec quis gravida nibh. Vestibulum et congue arcu. In hac habitasse platea dictumst. Nunc facilisis lorem ut cursus faucibus. Pellentesque eget mattis dolor, eu viverra sem. Vestibulum ut facilisis est. Suspendisse luctus neque nec facilisis rutrum."
klass_played = "nteger in varius augue. Pellentesque rhoncus mi at urna molestie, faucibus sollicitudin orci finibus. Praesent varius ex sit amet erat interdum, nec pellentesque dolor lobortis. Phasellus pretium ex eu lectus tincidunt, in congue sapien consequat. Etiam semper dignissim vestibulum. Fusce egestas sapien quis consectetur finibus. Pellentesque luctus tempus neque in pretium. Quisque dictum neque a erat feugiat dapibus."
bio = "Pellentesque sed scelerisque purus. Proin tincidunt, turpis id commodo congue, ipsum augue feugiat odio, commodo semper lectus purus luctus est. Mauris ut lacinia lorem. Quisque sit amet ligula sem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed feugiat tortor urna, vel ultrices orci lacinia a."
raid_experience = "Sed et dignissim nulla, nec viverra nisl. Pellentesque posuere fermentum faucibus. Proin ac suscipit augue. Mauris eget elementum est, non feugiat nisi. Suspendisse euismod ullamcorper sapien sed iaculis. Aliquam eget vulputate nunc. Etiam sed eros convallis, porttitor nisi id, porta lacus. In justo urna, sagittis sed lacus sed, varius auctor nisl. Donec et lacus in felis ullamcorper dignissim vitae id leo. Morbi cursus elit eu lectus scelerisque, vitae dictum lorem pellentesque."
reason = "Aenean a nulla in ligula convallis auctor. Cras vitae orci sit amet ligula imperdiet efficitur et a felis. Integer iaculis maximus mi, ac tempus ipsum scelerisque a. Nam aliquet iaculis nisl at rhoncus. Integer mattis eget justo pretium imperdiet. Mauris viverra ex ex, consequat rutrum dui aliquam sit amet."
old_guild = "Pellentesque molestie lacus eu est scelerisque convallis. In sagittis lacus id bibendum consectetur. Suspendisse maximus consectetur ante ac ultricies. Fusce in orci faucibus, imperdiet mauris id, mollis lorem. Mauris eleifend arcu ut arcu pellentesque, a gravida lacus mollis."
progress_raid = "Morbi volutpat felis sed lectus cursus, at cursus purus ornare. Phasellus tincidunt, ex at viverra ultrices, felis nisi volutpat nisi, at facilisis risus nulla at lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac mi tincidunt eros tincidunt vulputate."
attendance = "Nullam cursus facilisis hendrerit. Maecenas in malesuada nibh. Vestibulum at maximus lacus, vel finibus sapien. Nulla dolor risus, faucibus eget turpis a, vehicula fringilla sem. In vitae interdum velit. Aenean sit amet condimentum est."
other = "Nej"

GuildApplication.create(
  first_name: "Björn",
  last_name: "Grunde",
  email: "bjorngrunde@live.se",
  username: "Bombka",
  armory: "",
  klass: :hunter,
  server: "Grim-Batol",
  spec: "Beast Mastery",
  played: played,
  klass_played: klass_played,
  bio: bio,
  raid_experience: raid_experience,
  reason: reason,
  old_guild: old_guild,
  progress_raid: progress_raid,
  attendance: attendance,
  other: other,
  status: :pending)

GuildApplication.create(
  first_name: "Lars",
  last_name: "Jansson",
  email: "test1@live.se",
  username: "Bubbleoncd",
  armory: "",
  klass: :paladin,
  server: "Grim-Batol",
  spec: "Holy",
  played: played,
  klass_played: klass_played,
  bio: bio,
  raid_experience: raid_experience,
  reason: reason,
  old_guild: old_guild,
  progress_raid: progress_raid,
  attendance: attendance,
  other: other,
  status: :pending)

GuildApplication.create(
  first_name: "Kalle",
  last_name: "Kvastskaft",
  email: "test2@live.se",
  username: "Smeck",
  armory: "",
  klass: :mage,
  server: "Grim-Batol",
  spec: "Frost",
  played: played,
  klass_played: klass_played,
  bio: bio,
  raid_experience: raid_experience,
  reason: reason,
  old_guild: old_guild,
  progress_raid: progress_raid,
  attendance: attendance,
  other: other)

GuildApplication.create(
  first_name: "Sara",
  last_name: "Uggla",
  email: "test3@live.se",
  username: "Lillablå",
  armory: "",
  klass: :priest,
  server: "Grim-Batol",
  spec: "Shadow",
  played: played,
  klass_played: klass_played,
  bio: bio,
  raid_experience: raid_experience,
  reason: reason,
  old_guild: old_guild,
  progress_raid: progress_raid,
  attendance: attendance,
  other: other)

GuildApplication.create(
  first_name: "Hasse",
  last_name: "Blad",
  email: "test4@live.se",
  username: "Constermock",
  armory: "",
  klass: :warrior,
  server: "Grim-Batol",
  spec: "Arms",
  played: played,
  klass_played: klass_played,
  bio: bio,
  raid_experience: raid_experience,
  reason: reason,
  old_guild: old_guild,
  progress_raid: progress_raid,
  attendance: attendance,
  other: other)
