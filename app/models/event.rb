class Event < ApplicationRecord

  enum difficulty: { normal: 0, heroic: 1, mythic: 2 }

  belongs_to :user
  belongs_to :dungeon
  has_many :invites, class_name: 'Invite', as: :inviteable, dependent: :destroy

  scope :today_and_forward, -> { where("DATE(start_date) >= ?", Date.today).order(:start_date) }
  scope :public_events, -> { where(guild_event: false )}
  scope :guild_events, -> { where(guild_event: true )}
end
