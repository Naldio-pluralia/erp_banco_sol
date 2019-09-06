# This migration comes from next_sgad (originally 20171115140048)
class CorrectsStatus < ActiveRecord::Migration[5.1]
  def change

    rename_column :next_sgad_assessments, :state, :status
  end
end
