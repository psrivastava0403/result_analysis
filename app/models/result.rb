class Result < ApplicationRecord
    validates :student_name, :subject, :marks, :taken_at, presence: true
    validates :marks, numericallity: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
