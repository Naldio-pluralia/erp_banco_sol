# This migration comes from next_sgad (originally 20171029154047)
class AddComentToNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_goals, :employee_note, :text
    add_column :next_sgad_employee_goals, :supervisor_note, :text
  end
end
