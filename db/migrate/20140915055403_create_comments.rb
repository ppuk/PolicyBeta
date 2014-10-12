class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :commentable, polymorphic: true, index: true
      t.belongs_to :parent_comment, index: true
      t.belongs_to :user, index: true
      t.text :body
      t.integer :comments_count, default: 0, null: false

      t.timestamps
    end

    add_column :policies, :comments_count, :integer, default: 0, null: false
  end
end
