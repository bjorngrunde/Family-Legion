class AddIndexToAlts < ActiveRecord::Migration[5.0]
  def change
    add_index :alts, :name, :unique => true
  end
end
