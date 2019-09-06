class AddDateToProcessSalaries < ActiveRecord::Migration[5.1]
  def change
    add_column :remuneration_settings, :day_to_process_salaries, :integer, default: 28, null: false
    add_column :remuneration_settings, :month_to_process_christmas_subsidy, :integer, default: 11, null: false
  end
end
