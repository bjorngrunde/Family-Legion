class ChangeForumGroupsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :forum_groups, :slug, :string
    add_index :forum_groups, :slug, :unique => true
  end
end
