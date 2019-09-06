# This migration comes from next_sgad (originally 20180107204755)
class CreateJoinTableMessageDepartment < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_messages, :next_sgad_departments do |t|
      t.index [:next_sgad_message_id, :next_sgad_department_id], name: 'idx_nt_sd_depents_meges_on_sgad_message_id_and_sgad_depent_id'
      # t.index [:department_id, :message_id]
    end
  end
end
