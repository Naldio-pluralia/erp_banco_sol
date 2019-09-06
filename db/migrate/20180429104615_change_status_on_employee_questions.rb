class ChangeStatusOnEmployeeQuestions < ActiveRecord::Migration[5.1]
  def change
    change_column :employee_questions, :status, :integer, null: false, default: 0
  end
end
