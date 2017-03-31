class CreateForumGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_groups do |t|
      t.integer :user_id
      t.string  :title
      t.timestamps
    end
  end
end
