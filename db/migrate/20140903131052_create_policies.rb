class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.string :title
      t.text :description
      t.belongs_to :submitter, index: true
      t.string :category

      t.timestamps
    end
  end
end
