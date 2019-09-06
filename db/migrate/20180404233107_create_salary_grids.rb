class CreateSalaryGrids < ActiveRecord::Migration[5.1]
  def up
    create_table :salary_grids do |t|
      t.integer :number, null: false
      t.integer :code, null: false
      t.decimal :value_80, default: 0, null: false
      t.decimal :value_100, default: 0, null: false
      t.decimal :value_110, default: 0, null: false
      t.decimal :value_125, default: 0, null: false

      t.timestamps
    end
  end

  def down
    drop_table :salary_grids
  end
end
