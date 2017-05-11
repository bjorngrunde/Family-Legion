class Invite < ApplicationRecord

  enum role: { tank: 0, healer: 1, ranged: 2, melee: 3}
  enum status: { accepted: 0, not_sure: 1, declined: 2, selected: 3 }

  belongs_to :inviteable, polymorphic: true
  belongs_to :user

  scope :role_is, ->(role) { where(role: role ).order("
    CASE status
    WHEN status = '3' THEN '1'
    WHEN status = '0' THEN '2'
    WHEN status = '1' THEN '3'
    WHEN status = '2' THEN '4' ASC ") }
  scope :joined, -> { where.not(role: nil) }
  scope :not_declined, -> { where.not(role: :declined )}
end
