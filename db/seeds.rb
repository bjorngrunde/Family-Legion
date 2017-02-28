# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Should be extracted to its own seed file later on


#Create 12 users, one of each proffession(World of Warcraft class, not to be confused with a Class)
User::CreateUserFromGuildApplication.(user: { username: "Sprayandpray", email: "bjorngrunde@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "hunter", rank: 1, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Dubbelmums", email: "dubbelmums@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "warlock", rank: 1, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Bombka", email: "bombka@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "warrior", rank: 1, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Nightshade", email: "nightshade@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "druid", rank: 1, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Stickado", email: "stickado@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "rogue", rank: 1, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "burnmtfkrs", email: "burnmtfkrs@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "mage", rank: 1, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Rigormoris", email: "rigor@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "priest", rank: 3, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Izhrak", email: "izhrak@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "death_knight", rank: 3, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Litenmenvass", email: "litenmenvass@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "monk", rank: 3, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Bäverbonkarn", email: "baverbonkarn@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "shaman", rank: 3, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Bubbleoncd", email: "bubbleoncd@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "paladin", rank: 3, server: "grim batol", spec: "Beast Mastery"} })
User::CreateUserFromGuildApplication.(user: { username: "Demonhoney", email: "bubbleoncd@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "demon_hunter", rank: 3, server: "grim batol", spec: "Beast Mastery"} })