class AddEmailConfirmationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_confirmation_token, :string, default: nil
    add_index :users, :email_confirmation_token
    add_column :users, :email_confirmed_on, :datetime, default: nil
    add_index :users, :email_confirmed_on
  end
end
