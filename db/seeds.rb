puts "Seeding data..."

subjects = ["Math", "Science", "English"]
name = ["Ram", "Mohit", "Rohit", "John"]

start_date = 15.days.ago.to_date
end_date   = Date.today

records_per_day = 15  
# 15 × 15 days ≈ 225 records

(start_date..end_date).each do |date|
  records_per_day.times do
    Result.create!(
      student_name: name.sample,
      subject: subjects.sample,
      marks: rand(40..100),
      taken_at: date.to_time + rand(0..23).hours
    )
  end
end

puts "Seeding completed!"
puts "Total Results: #{Result.count}"