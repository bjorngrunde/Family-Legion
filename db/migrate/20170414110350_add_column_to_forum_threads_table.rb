class AddColumnToForumThreadsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :forum_threads, :forum_comments_count, :string
  end
end
