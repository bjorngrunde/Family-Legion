class NotificationRelayJob < ApplicationJob
  include Trailblazer::Cell
  queue_as :default

  def perform(notification)
    html = ActionController.render cell("Notification::Cell::#{notification.notifiable_type}".constantize, notification)
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  end
end
