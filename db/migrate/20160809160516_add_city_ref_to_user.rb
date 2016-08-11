class AddCityRefToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :city, foreign_key: true
  end
end
