class CreatePubs < ActiveRecord::Migration[5.0]
  def change
    create_table :pubs do |t|
      t.string :name
      t.string :description
      t.integer :phone
      t.string :email
      t.boolean :hidden

      t.timestamps
    end
  end
end
