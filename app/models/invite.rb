class Invite < ApplicationRecord

  enum role: { tank: 0, healer: 1, ranged: 2, melee: 3}
  enum status: { accepted: 0, not_sure: 1, declined: 2 }

  belongs_to :inviteable, polymorphic: true
  belongs_to :user

  scope :role_is, ->(role) { where(role: role ).order(:status) }
  scope :joined, ->{ where.not(role: nil) }
end
