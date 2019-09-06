class CreateRemunerationSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :remuneration_settings do |t|
      t.decimal :base_salary, default: 0, null: false

      t.timestamps
    end
  end
end
