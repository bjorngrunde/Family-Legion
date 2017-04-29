class CreateForumThreads < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_threads do |t|
      t.string  :title
      t.string  :url
      t.text    :body
      t.belongs_to :forum_group, index: true
      t.belongs_to :forum_category, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end

    add_index :forum_threads, [:url, :title], :unique => true
  end
end
