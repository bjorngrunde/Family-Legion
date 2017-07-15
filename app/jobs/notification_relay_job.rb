class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = ApplicationController.renderer.render(partial: "notifications/partials/#{notification.notifiable_type.underscore}", locals: { notification: notification })
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
  end
end
