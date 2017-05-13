class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :difficulty
      t.boolean :public, default: 0
      t.boolean :guild_event, default: 0
      t.string :start_time
      t.string :end_time
      t.date :start_date
      t.belongs_to :dungeon
      t.belongs_to :user
      t.timestamps
    end
  end
end
