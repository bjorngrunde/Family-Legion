class CreateViewsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :views do |t|
      t.integer :user_id
      t.references :viewable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
