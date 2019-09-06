# This migration comes from next_sgad (originally 20171113125224)
class AddConfigurationColumnsToNextsSgadAssessment < ActiveRecord::Migration[5.1]
  def change
    add_column :next_sgad_assessments, :number_of_four_hours_delay_to_absence, :integer, default: 0, null: false
    add_column :next_sgad_assessments, :number_of_three_hours_delay_to_absence, :integer, default: 0, null: false
    add_column :next_sgad_assessments, :number_of_two_hours_delay_to_absence, :integer, default: 0, null: false
    add_column :next_sgad_assessments, :number_of_one_hour_delay_to_absence, :integer, default: 0, null: false

    remove_column :next_sgad_assessments, :four_hours_late_discount,   :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :three_hours_late_discount,  :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :two_hours_late_discount,    :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :one_hour_late_discount,     :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :presence_discount,          :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :absence_discount,           :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :justified_absence_discount, :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :vacation_discount,          :decimal, default: 0, null: false
    remove_column :next_sgad_assessments, :authorized_leave_discount,  :decimal, default: 0, null: false
  end
end
