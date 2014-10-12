class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :colour

      t.timestamps
    end

    remove_column :policies, :category, :string
    add_column :policies, :category_id, :integer
    add_index :policies, :category_id

  end
end
