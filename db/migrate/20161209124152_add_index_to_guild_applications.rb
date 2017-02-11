class AddIndexToGuildApplications < ActiveRecord::Migration[5.0]
  def change
    add_index :guild_applications, [:email, :username], :unique => true
  end
end
