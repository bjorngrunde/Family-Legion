class AddIndexToForumGroups < ActiveRecord::Migration[5.0]
  def change
    add_index :forum_groups, :title, :unique => true
  end
end
