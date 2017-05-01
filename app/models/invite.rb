class Invite < ApplicationRecord

  enum role: { tank: 0, healer: 1, ranged: 2, melee: 3}

  belongs_to :inviteable, polymorphic: true
end
