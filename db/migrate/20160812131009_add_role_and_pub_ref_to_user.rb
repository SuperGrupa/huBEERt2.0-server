class AddRoleAndPubRefToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: 'user'
    add_reference :users, :pub, foreign_key: true, null: true
  end
end
