class AddColumnLockedToForumThreadsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :forum_threads, :is_locked, :boolean, default: false
  end
end
