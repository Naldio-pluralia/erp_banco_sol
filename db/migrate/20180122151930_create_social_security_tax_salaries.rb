class CreateSocialSecurityTaxSalaries < ActiveRecord::Migration[5.1]
  def change
    create_table :social_security_tax_salaries do |t|
      t.decimal :value, null: false
      t.references :salary, foreign_key: true
      t.references :social_security_tax, foreign_key: true

      t.timestamps
    end
  end
end
