class ChangeNotificationConnections < ActiveRecord::Migration[5.0]
  def change
    drop_table :notifications_users

    add_column :notifications, :read, :boolean
    add_reference :notifications, :user, foreign_key: true
  end
end
