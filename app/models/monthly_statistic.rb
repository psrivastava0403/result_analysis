class MonthlyStatistic < ApplicationRecord
  validates :start_date, :end_date, :total_count, presence: true

  validates :start_date, uniqueness: { scope: :end_date }
end