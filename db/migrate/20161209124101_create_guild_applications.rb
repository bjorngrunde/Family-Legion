class CreateGuildApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :guild_applications do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :username
      t.string :server
      t.string :spec
      t.string  :armory
      t.integer :klass
      t.text  :played
      t.text  :klass_played
      t.text  :bio
      t.text  :raid_experience
      t.text  :reason
      t.text  :old_guild
      t.text  :progress_raid
      t.text  :attendance
      t.text  :image_meta_data
      t.text  :other
      t.integer :status
      t.timestamps
    end
  end
end
