roles = [:developer, :admin, :moderator, :member, :newbie]
roles.each do |role|
  Role.create({name: role})
end