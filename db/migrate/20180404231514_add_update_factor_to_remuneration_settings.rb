class AddUpdateFactorToRemunerationSettings < ActiveRecord::Migration[5.1]
  def up
    add_column :remuneration_settings, :update_factor, :decimal, default: 15, null: false
    RemunerationSetting.last&.update_columns(base_salary: 52000, update_factor: 15) || RemunerationSetting.create(base_salary: 52000, update_factor: 15)
  end

  def down
    remove_column :remuneration_settings, :update_factor, :decimal, default: 15, null: false
  end
end
