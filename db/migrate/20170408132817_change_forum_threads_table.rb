class ChangeForumThreadsTable < ActiveRecord::Migration[5.0]
  def change
    change_table :forum_threads do |t|
      t.rename :url, :slug
    end
    add_index :forum_threads, :slug, :unique => true
  end
end
