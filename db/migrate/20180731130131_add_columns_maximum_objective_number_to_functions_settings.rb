class AddColumnsMaximumObjectiveNumberToFunctionsSettings < ActiveRecord::Migration[5.1]
  def change
      add_column :function_settings, :maximum_objective_number, :integer, default: 0, null: false
  end
end
