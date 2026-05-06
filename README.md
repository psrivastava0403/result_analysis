# 📊 Result Analysis System

## 🚀 Overview

This application processes student results and generates aggregated statistics using background jobs.

The system performs:

* **Daily aggregation** of results per subject
* **Monthly aggregation** based on a threshold (≥ 200 results)
* **Scheduled execution** using Sidekiq

---

## 🧠 Architecture

```
Results (raw data)
        ↓
DailyStatisticsJob (per day aggregation)
        ↓
DailyStatistic (per subject per day)
        ↓
MonthlyStatisticsJob (threshold-based aggregation)
        ↓
MonthlyStatistic (final aggregated output)
```

---

## ⚙️ Tech Stack

* Ruby on Rails 7
* PostgreSQL
* Sidekiq (Background Jobs)
* Redis
* RSpec (Testing)

---

## 📦 Setup Instructions

### 1. Clone the repository

```
git clone https://github.com/psrivastava0403/result_analysis.git
cd result_analysis
```

---

### 2. Install dependencies

```
bundle install
```

---

### 3. Setup database

```
rails db:create
rails db:migrate
```

---

### 4. Seed data (for testing)

```
rails db:seed
```

---

### 5. Start Redis

```
redis-server
```

---

### 6. Start Sidekiq

```
bundle exec sidekiq
```

---

## ▶️ Running Jobs

### Daily Job

```
DailyStatisticsJob.perform_now
```

👉 For historical backfill:

```
(15.days.ago.to_date..Date.today).each do |date|
  DailyStatisticsJob.perform_now(date)
end
```

---

### Monthly Job

```
MonthlyStatisticsJob.perform_now
```

---

## 🔁 Scheduling

Jobs are scheduled using Sidekiq Cron:

* Daily Job → Runs every day
* Monthly Job → Runs weekly (with internal condition check)

---

## 📊 Database Schema

### Results

* student_name
* subject
* marks
* taken_at

### DailyStatistic

* date
* subject
* daily_low
* daily_high
* result_count

### MonthlyStatistic

* avg_low
* avg_high
* total_count
* start_date
* end_date

👉 Unique constraint applied on:

```
[start_date, end_date]
```

---

## 🧪 Running Tests

```
bundle exec rspec
```

---

## ✅ Features

* Data aggregation pipeline
* Background job processing
* Idempotent monthly calculation (via upsert)
* Validation-safe job execution
* API endpoint for result creation

---

## 🔌 API

### Create Result

```
POST /api/v1/results
```

#### Request Body:

```
{
  "student_name": "Prashant",
  "subject": "Math",
  "marks": 85,
  "taken_at": "2026-05-06T10:00:00Z"
}
```

#### Response:

```
{
  "message": "Successfully Saved!!"
}
```

---

## ⚠️ Assumptions

* Monthly aggregation runs only when total results ≥ 200
* Duplicate monthly records are prevented using unique index
* Jobs are safe against empty datasets

---

## 🔥 Design Decisions

* Used background jobs to ensure scalability
* Used upsert to maintain idempotency
* Separated daily and monthly aggregation for modularity
* Added validations to ensure data integrity

---

## 🧠 Notes

* `perform_now` used for testing
* `perform_later` used in production with Sidekiq
* Historical data backfill handled manually for testing

---

## 📌 Author

Prashant Srivastava

---
