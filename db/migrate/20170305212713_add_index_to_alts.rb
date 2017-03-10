class AddIndexToAlts < ActiveRecord::Migration[5.0]
  def change
    add_index :alts, :username, :unique => true
  end
end
