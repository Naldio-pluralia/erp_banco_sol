class CreateTaxSalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :tax_salaries do |t|
      t.decimal :value, null: false, default: 0
      t.references :salary, foreign_key: true
      t.references :tax_type, foreign_key: true

      t.timestamps
    end
  end
end
