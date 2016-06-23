class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :pub, foreign_key: true
      t.string :name
      t.date :datetime
      t.string :description

      t.timestamps
    end
  end
end
