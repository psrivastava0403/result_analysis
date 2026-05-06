FactoryBot.define do
  factory :daily_statistic do
    date { "2026-05-06" }
    subject { "MyString" }
    daily_low { 1 }
    daily_high { 1 }
    result_count { 1 }
  end
end
