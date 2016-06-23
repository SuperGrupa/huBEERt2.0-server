class CreateBeers < ActiveRecord::Migration[5.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :description
      t.decimal :alcohol
      t.decimal :extract
      t.decimal :volume

      t.timestamps
    end
  end
end
