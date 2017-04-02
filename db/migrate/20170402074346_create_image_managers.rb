class CreateImageManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :image_managers do |t|
      t.belongs_to :user, index: true
      t.text    :image_meta_data
      t.timestamps
    end
  end
end
