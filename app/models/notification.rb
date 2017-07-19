class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(is_read: false) }

  #after_commit -> { NotificationRelayJob.perform_later(self) }
end
