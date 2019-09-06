class AddIsSelectedToEmployeeQuestionOptions < ActiveRecord::Migration[5.1]
  def change
    add_column :employee_question_options, :is_selected, :boolean, default: false, null: false
    remove_column :employee_question_options, :status, :integer, default: 0, null: false
  end
end
