require 'rails_helper'

RSpec.describe Result, type: :model do
  it "is valid with valid attributes" do
    result = Result.new(
      student_name: "Test",
      subject: "Math",
      marks: 80,
      taken_at: Time.current
    )
    expect(result).to be_valid
  end

  it "is invalid without marks" do
    result = Result.new(marks: nil)
    expect(result).not_to be_valid
  end

  it "is invalid if marks > 100" do
    result = Result.new(marks: 120)
    expect(result).not_to be_valid
  end

  it "is invalid if marks < 0" do
    result = Result.new(marks: -5)
    expect(result).not_to be_valid
  end
end