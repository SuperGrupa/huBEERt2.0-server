class ChangeDatetimeToDateInEvents < ActiveRecord::Migration[5.0]
  def self.up
    change_column :events, :datetime, :datetime
    rename_column :events, :datetime, :date
  end

  def self.down
    change_column :events, :date, :date
    rename_column :events, :date, :datetime
  end
end
