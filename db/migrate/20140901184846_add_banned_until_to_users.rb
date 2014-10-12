class AddBannedUntilToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banned_until, :datetime
  end
end
