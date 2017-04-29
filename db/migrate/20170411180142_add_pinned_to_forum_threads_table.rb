class AddPinnedToForumThreadsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :forum_threads, :pinned, :boolean, default: false
  end
end
