class Invites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.references :inviteable, polymorphic: true, index: true
      t.string :notice
      t.integer :role
      t.integer :status
      t.timestamps
    end
  end
end
