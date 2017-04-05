class Alt < ApplicationRecord
  include Authority::Abilities

  self.authorizer_name = 'AdminAuthorizer'
  
  belongs_to :user

  enum klass: {death_knight: 1, druid: 2, demon_hunter: 3, hunter: 4, mage: 5, monk: 6, priest: 7, paladin: 8, rogue: 9, shaman: 10, warlock: 11, warrior: 12}
end
