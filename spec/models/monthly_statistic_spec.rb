require 'rails_helper'

RSpec.describe MonthlyStatistic, type: :model do
  it "is valid with valid attributes" do
    stat = MonthlyStatistic.new(
      avg_low: 40.5,
      avg_high: 90.2,
      total_count: 200,
      start_date: Date.today - 10,
      end_date: Date.today
    )
    expect(stat).to be_valid
  end

  it "does not allow duplicate records for same date range" do
    MonthlyStatistic.create!(
      avg_low: 40,
      avg_high: 90,
      total_count: 200,
      start_date: Date.today - 10,
      end_date: Date.today
    )

    duplicate = MonthlyStatistic.new(
      avg_low: 45,
      avg_high: 95,
      total_count: 210,
      start_date: Date.today - 10,
      end_date: Date.today
    )

    expect(duplicate).not_to be_valid
  end
end