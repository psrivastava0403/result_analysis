class DailyStatistic < ApplicationRecord
  validates :date, :subject, :daily_low, :daily_high, :result_count, presence: true

  validates :result_count, numericality: { greater_than_or_equal_to: 0 }
end