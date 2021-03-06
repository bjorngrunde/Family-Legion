class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.belongs_to :user
      t.text :body
      t.timestamps
    end
  end
end
