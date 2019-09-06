# This migration comes from next_sgad (originally 20180211221158)
class CreateNextSgadEmployeeGoalActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :next_sgad_employee_goal_activities do |t|
      t.text :description
      t.references :employee_goal, foreign_key: {to_table: :next_sgad_employee_goals}
      t.references :creator, polymorphic: true, index: {name: 'index_employee_goal_activities_on_creator_type_and_creator_id'}
      t.string :attachment

      t.timestamps
    end
  end
end
