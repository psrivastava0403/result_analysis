require 'rails_helper'

RSpec.describe DailyStatisticsJob, type: :job do
  let(:date) { Date.today }

  before do
    Result.create!(student_name: "A", subject: "Math", marks: 50, taken_at: date)
    Result.create!(student_name: "B", subject: "Math", marks: 90, taken_at: date)
    Result.create!(student_name: "C", subject: "Science", marks: 70, taken_at: date)
  end

  it "creates daily statistics per subject" do
    expect {
      described_class.perform_now(date)
    }.to change(DailyStatistic, :count).by(2)

    stat = DailyStatistic.find_by(subject: "Math")

    expect(stat.daily_low).to eq(50)
    expect(stat.daily_high).to eq(90)
    expect(stat.result_count).to eq(2)
  end
end