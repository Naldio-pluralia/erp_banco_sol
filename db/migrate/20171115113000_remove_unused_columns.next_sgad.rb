# This migration comes from next_sgad (originally 20171115111821)
class RemoveUnusedColumns < ActiveRecord::Migration[5.1]
  def change
    # from employees
    remove_column :next_sgad_employees, :email, :string if column_exists? :next_sgad_employees, :email
    remove_column :next_sgad_employees, :name, :string if column_exists? :next_sgad_employees, :name
    # from goals
    remove_column :next_sgad_goals, :percentage, :decimal if column_exists? :next_sgad_goals, :percentage
    remove_column :next_sgad_goals, :percentage_on_the_type, :decimal if column_exists? :next_sgad_goals, :percentage_on_the_type
    # from employee goals
    remove_column :next_sgad_employee_goals, :percentage, :decimal if column_exists? :next_sgad_employee_goals, :percentage
    # from justifications
    remove_column :next_sgad_justifications, :assessment_id, :bigint if column_exists? :next_sgad_justifications, :assessment_id
    remove_column :next_sgad_justifications, :position_id, :bigint if column_exists? :next_sgad_justifications, :position_id
    remove_column :next_sgad_justifications, :department_id, :bigint if column_exists? :next_sgad_justifications, :department_id
    # Just renames this columns
    rename_column :next_sgad_goals, :state, :status if column_exists? :next_sgad_goals, :state
    rename_column :next_sgad_employee_goals, :state, :status if column_exists? :next_sgad_employee_goals, :state
  end
end
