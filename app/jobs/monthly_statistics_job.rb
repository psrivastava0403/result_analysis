# app/jobs/monthly_statistics_job.rb
class MonthlyStatisticsJob < ApplicationJob
  queue_as :default

  def perform
    return unless run_today?

    stats = fetch_stats
    return if stats.blank?

    avg_high = stats.sum(&:daily_high) / stats.size.to_f
    avg_low  = stats.sum(&:daily_low) / stats.size.to_f
    total    = stats.sum(&:result_count)

    start_date = stats.first.date
    end_date   = stats.last.date

    # Idempotent write (no duplicate)
    MonthlyStatistic.upsert(
      {
        start_date: start_date,
        end_date: end_date,
        avg_high: avg_high,
        avg_low: avg_low,
        total_count: total,
        created_at: Time.current,
        updated_at: Time.current
      },
      unique_by: %i[start_date end_date]
    )
  end

  private

  # Run only on Monday of the week containing 3rd Wednesday
  def run_today?
    today = Time.zone.today

    third_wed = nth_wday_of_month(3, 3, today.month, today.year)
    week_start = third_wed.beginning_of_week(:monday)

    today == week_start
  end

  # Find nth weekday of a month
  def nth_wday_of_month(n, wday, month, year)
    first = Date.new(year, month, 1)
    first += (wday - first.wday) % 7
    first + (n - 1) * 7
  end

  def fetch_stats
    all_stats = DailyStatistic
                  .select(:date, :daily_high, :daily_low, :result_count)
                  .order(date: :desc)
                  .to_a

    return [] if all_stats.empty?

    stats = all_stats.first(5)
    total = stats.sum(&:result_count)

    i = 5
    while total < 200 && i < all_stats.size
      stats << all_stats[i]
      total += all_stats[i].result_count
      i += 1
    end

    stats.reverse
  end
end