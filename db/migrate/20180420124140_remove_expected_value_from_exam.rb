class RemoveExpectedValueFromExam < ActiveRecord::Migration[5.1]
  def change
    remove_column :exams, :expected_value if table_exists? :exams
  end
end
