class CreateForumCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_categories do |t|
      t.string  :title
      t.string  :description
      t.string  :role
      t.integer :forum_group_id
      t.timestamps
    end
  end
end
