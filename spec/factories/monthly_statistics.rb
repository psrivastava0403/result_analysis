FactoryBot.define do
  factory :monthly_statistic do
    avg_low { 1.5 }
    avg_high { 1.5 }
    total_count { 1 }
    start_date { "2026-05-06" }
    end_date { "2026-05-06" }
  end
end
