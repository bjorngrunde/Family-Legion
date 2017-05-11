class Invite < ApplicationRecord

  enum role: { tank: 0, healer: 1, ranged: 2, melee: 3}
  enum status: { selected: 0, accepted: 1, not_sure: 2, declined: 3 }

  belongs_to :inviteable, polymorphic: true
  belongs_to :user

  scope :role_is, ->(role) { where(role: role ).order("status asc").partition { |invite| invite.status == :selected }.flatten }
  scope :joined, -> { where.not(role: nil) }
end
