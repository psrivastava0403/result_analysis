require 'rails_helper'

RSpec.describe MonthlyStatisticsJob, type: :job do
  before do
    # create enough daily stats to cross 200
    10.times do |i|
      DailyStatistic.create!(
        date: Date.today - i,
        subject: "Math",
        daily_low: 40,
        daily_high: 90,
        result_count: 25
      )
    end
  end

  it "creates monthly statistic when total >= 200" do
    allow_any_instance_of(MonthlyStatisticsJob).to receive(:run_today?).and_return(true)

    expect {
      described_class.perform_now
    }.to change(MonthlyStatistic, :count).by(1)

    stat = MonthlyStatistic.last

    expect(stat.total_count).to be >= 200
  end
end