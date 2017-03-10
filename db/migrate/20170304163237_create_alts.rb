class CreateAlts < ActiveRecord::Migration[5.0]
  def change
    create_table :alts do |t|
      t.string  :username
      t.integer :user_id
      t.string  :thumbnail
      t.integer :klass
      t.string  :server
      t.timestamps
    end
  end
end
