class CreateDungeons < ActiveRecord::Migration[5.0]
  def change
    create_table :dungeons do |t|
      t.string :name, unique: true
      t.integer :dungeon_type
      t.text :image_meta_data
      t.timestamps
    end
  end
end
