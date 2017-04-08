class ChangeForumCategoriesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :forum_categories, :slug, :string
    add_index :forum_categories, :slug, :unique => true
  end
end
