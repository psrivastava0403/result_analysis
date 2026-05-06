class CreateMonthlyStatistics < ActiveRecord::Migration[7.1]
  def change
    create_table :monthly_statistics do |t|
      t.float :avg_low
      t.float :avg_high
      t.integer :total_count
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
