class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.references :pub, foreign_key: true
      t.references :beer, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
