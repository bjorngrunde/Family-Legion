roles = [:developer, :admin, :moderator, :raid_leader, :raider,  :member, :newbie]
roles.each do |role|
  Role.create({name: role})
end
