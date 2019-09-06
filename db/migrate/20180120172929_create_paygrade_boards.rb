class CreatePaygradeBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :paygrade_boards do |t|
      t.decimal :level_1_value, default: 0, null: false
      t.decimal :level_1_increment, default: 0, null: false
      t.decimal :level_1_a_value, default: 0, null: false
      t.decimal :level_1_b_value, default: 0, null: false
      t.decimal :level_1_c_value, default: 0, null: false
      t.decimal :level_1_d_value, default: 0, null: false
      t.decimal :level_2_value, default: 0, null: false
      t.decimal :level_2_increment, default: 0, null: false
      t.decimal :level_2_a_value, default: 0, null: false
      t.decimal :level_2_b_value, default: 0, null: false
      t.decimal :level_2_c_value, default: 0, null: false
      t.decimal :level_2_d_value, default: 0, null: false
      t.decimal :level_3_value, default: 0, null: false
      t.decimal :level_3_increment, default: 0, null: false
      t.decimal :level_3_a_value, default: 0, null: false
      t.decimal :level_3_b_value, default: 0, null: false
      t.decimal :level_3_c_value, default: 0, null: false
      t.decimal :level_3_d_value, default: 0, null: false
      t.decimal :level_4_value, default: 0, null: false
      t.decimal :level_4_increment, default: 0, null: false
      t.decimal :level_4_a_value, default: 0, null: false
      t.decimal :level_4_b_value, default: 0, null: false
      t.decimal :level_4_c_value, default: 0, null: false
      t.decimal :level_4_d_value, default: 0, null: false
      t.decimal :level_5_value, default: 0, null: false
      t.decimal :level_5_increment, default: 0, null: false
      t.decimal :level_5_a_value, default: 0, null: false
      t.decimal :level_5_b_value, default: 0, null: false
      t.decimal :level_5_c_value, default: 0, null: false
      t.decimal :level_5_d_value, default: 0, null: false
      t.decimal :level_6_value, default: 0, null: false
      t.decimal :level_6_increment, default: 0, null: false
      t.decimal :level_6_a_value, default: 0, null: false
      t.decimal :level_6_b_value, default: 0, null: false
      t.decimal :level_6_c_value, default: 0, null: false
      t.decimal :level_6_d_value, default: 0, null: false
      t.decimal :level_7_value, default: 0, null: false
      t.decimal :level_7_increment, default: 0, null: false
      t.decimal :level_7_a_value, default: 0, null: false
      t.decimal :level_7_b_value, default: 0, null: false
      t.decimal :level_7_c_value, default: 0, null: false
      t.decimal :level_7_d_value, default: 0, null: false
      t.decimal :level_8_value, default: 0, null: false
      t.decimal :level_8_increment, default: 0, null: false
      t.decimal :level_8_a_value, default: 0, null: false
      t.decimal :level_8_b_value, default: 0, null: false
      t.decimal :level_8_c_value, default: 0, null: false
      t.decimal :level_8_d_value, default: 0, null: false
      t.decimal :level_9_value, default: 0, null: false
      t.decimal :level_9_increment, default: 0, null: false
      t.decimal :level_9_a_value, default: 0, null: false
      t.decimal :level_9_b_value, default: 0, null: false
      t.decimal :level_9_c_value, default: 0, null: false
      t.decimal :level_9_d_value, default: 0, null: false
      t.decimal :level_10_value, default: 0, null: false
      t.decimal :level_10_increment, default: 0, null: false
      t.decimal :level_10_a_value, default: 0, null: false
      t.decimal :level_10_b_value, default: 0, null: false
      t.decimal :level_10_c_value, default: 0, null: false
      t.decimal :level_10_d_value, default: 0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
