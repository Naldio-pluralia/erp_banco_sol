class CreateSalaryBoardItems < ActiveRecord::Migration[5.1]
  def change
    create_table :salary_board_items do |t|
      t.integer :paygrade, default: 1, null: false
      t.decimal :base_value, default: 0, null: false
      t.decimal :increment_value, default: 0, null: false
      t.decimal :a_value, default: 0, null: false
      t.decimal :b_value, default: 0, null: false
      t.decimal :c_value, default: 0, null: false
      t.decimal :d_value, default: 0, null: false
      t.references :salary_board, foreign_key: true

      t.timestamps
    end
  end
end
