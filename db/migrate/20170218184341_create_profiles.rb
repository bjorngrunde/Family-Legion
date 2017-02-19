class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
    	t.integer		:user_id, :null => false
    	t.string		:first_name, :limit => 45
    	t.string		:last_name, :limit => 45
    	t.integer		:klass
    	t.string		:server
    	t.string		:avatar
    	t.string		:thumbnail
    	t.string		:phone
    	t.integer		:rank
      t.timestamps
    end
  end
end
