class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :pub, foreign_key: true
      t.string :text
      t.integer :rating

      t.timestamps
    end
  end
end
