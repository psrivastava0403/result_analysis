class DailyStatisticsJob < ApplicationJob
  queue_as :default

  def perform(date = Date.today)
    # Do something later
    results = Result.where(taken_at: date.beginning_of_day..date.end_of_day)

    results.group(:subject).each do |subject, records|
      marks = records.map(&:marks)

      DailyStatistics.create!(
        date: date,
        subject: subject,
        daily_low: marks.min,
        daily_high: marks.max,
        result_count: marks.count
      )
    end
  end
end
