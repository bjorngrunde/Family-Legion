class Event < ApplicationRecord

  enum difficulty: { normal: 0, heroic: 1, mythic: 2 }

  belongs_to :user
  belongs_to :dungeon
  has_many :invites, class_name: 'Invite', as: :inviteable, dependent: :destroy

  scope :today_and_forward, -> { where("DATE(start_date) >= ?", Date.today).order(:start_date) }
  scope :public_or_invited, -> (user_id, guild_event, public_event ) { includes(:invites).where("invites.user_id = ? OR guild_event = ? OR public = ?", user_id, guild_event, public_event).references(:invites) }
  scope :public_events, -> { where(guild_event: false )}
  scope :guild_events, -> { where(guild_event: true )}
end
