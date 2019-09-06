class CreateWageIncomeTaxItems < ActiveRecord::Migration[5.1]
  def change
    create_table :wage_income_tax_items do |t|
      t.references :wage_income_tax, foreign_key: true
      t.decimal :from, default: 0, null: false
      t.decimal :to, default: 0, null: false
      t.decimal :fixed_portion, default: 0, null: false
      t.decimal :percentage_over_the_excess, default: 0, null: false
      t.decimal :excess_of, default: 0, null: false

      t.timestamps
    end
  end
end
