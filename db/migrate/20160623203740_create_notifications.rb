class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :event, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
