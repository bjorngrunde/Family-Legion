class CreateForumComments < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_comments do |t|
      t.text :body
      t.belongs_to :user
      t.belongs_to :forum_group
      t.belongs_to :forum_category
      t.belongs_to :forum_thread
      t.timestamps
    end
  end
end
