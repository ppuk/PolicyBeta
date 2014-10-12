class AddStateToPolicies < ActiveRecord::Migration
  def change
    add_column :policies, :state, :string, default: 'suggestion', null: false
    add_column :policies, :promotion_state, :string, default: :waiting, null: false
    add_index :policies, :state
    add_index :policies, :promotion_state
  end
end
