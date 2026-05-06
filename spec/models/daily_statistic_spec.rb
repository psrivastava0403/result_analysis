require 'rails_helper'

RSpec.describe DailyStatistic, type: :model do
  it "is valid with valid attributes" do
    stat = DailyStatistic.new(
      date: Date.today,
      subject: "Math",
      daily_low: 40,
      daily_high: 90,
      result_count: 10
    )
    expect(stat).to be_valid
  end

  it "is invalid without subject" do
    stat = DailyStatistic.new(subject: nil)
    expect(stat).not_to be_valid
  end

  it "is invalid if result_count is negative" do
    stat = DailyStatistic.new(result_count: -1)
    expect(stat).not_to be_valid
  end
end