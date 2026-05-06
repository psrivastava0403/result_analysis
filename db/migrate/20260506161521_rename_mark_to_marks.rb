class RenameMarkToMarks < ActiveRecord::Migration[7.1]
  def change
    rename_column :results, :mark, :marks
  end
end
