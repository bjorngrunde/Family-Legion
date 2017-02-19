class Profile < ApplicationRecord

	enum klass: {death_knight: 1, druid: 2, demon_hunter: 3, hunter: 4, mage: 5, monk: 6, priest: 7, paladin: 8, rogue: 9, shaman: 10, warlock: 11, warrior: 12}
	enum rank: {newbie: 1, casual: 2, raider: 3, officer: 4, guild_master: 5}
	#Associations
	belongs_to :user
end