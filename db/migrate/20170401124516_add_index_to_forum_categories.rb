class AddIndexToForumCategories < ActiveRecord::Migration[5.0]
  def change
    add_index :forum_categories, :title, :unique => true
  end
end
