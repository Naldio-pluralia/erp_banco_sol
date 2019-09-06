# This migration comes from next_sgad (originally 20171229114341)
class AddSupervisorSupervisorNoteToNextSgadEmployeeGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_employee_goals, :supervisor_supervisor_note, :text
  end
end
