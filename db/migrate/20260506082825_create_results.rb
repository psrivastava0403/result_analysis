class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.string :student_name
      t.string :subject
      t.integer :mark
      t.datetime :taken_at

      t.timestamps
    end
  end
end
