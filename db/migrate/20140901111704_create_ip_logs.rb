class CreateIpLogs < ActiveRecord::Migration
  def change
    add_column :users, :last_ip, :string

    create_table :ip_logs do |t|
      t.belongs_to :user, index: true
      t.string :ip
      t.datetime :last_seen

      t.timestamps
    end
    add_index :ip_logs, :ip
    add_index :ip_logs, :last_seen
    add_index :ip_logs, [:user_id, :ip], unique: true
  end
end
