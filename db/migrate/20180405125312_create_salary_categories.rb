class CreateSalaryCategories < ActiveRecord::Migration[5.1]
  def up
    create_table :salary_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    SalaryCategory.create(name: 'Técnico')
  end

  def down
    drop_table :salary_categories
  end
end
