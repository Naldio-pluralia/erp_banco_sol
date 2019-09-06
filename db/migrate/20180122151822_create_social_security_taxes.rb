class CreateSocialSecurityTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :social_security_taxes do |t|
      t.string :name, null: false
      t.string :abbr_name, null: false
      t.decimal :percentage, default: 0, null: false
      t.decimal :percentage_from_employee, default: 0, null: false
      t.decimal :percentage_from_employer, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
