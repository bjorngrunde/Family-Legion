# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Should be extracted to its own seed file later on


User::CreateUserFromGuildApplication.(user: { username: "Sprayandpray", email: "bjorngrunde@live.se", profile: { first_name: "Björn", last_name: "Grunde", klass: "hunter", rank: 1, server: "grim batol", spec: "Beast Mastery"} })