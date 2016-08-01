class AddCityRefToPub < ActiveRecord::Migration[5.0]
  def change
    add_reference :pubs, :city, foreign_key: true
  end
end
