class AddUniqueIndexToMonthlyStatistics < ActiveRecord::Migration[7.1]
  def change
    add_index :monthly_statistics, [:start_date, :end_date], unique: true
  end
end
