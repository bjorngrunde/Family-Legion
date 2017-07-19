class AddIsReadColumnToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :is_read, :boolean, default: 0
  end
end
