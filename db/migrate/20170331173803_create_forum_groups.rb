class CreateForumGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_groups do |t|
      t.string  :title
      t.string  :role
      t.timestamps
    end
  end
end
