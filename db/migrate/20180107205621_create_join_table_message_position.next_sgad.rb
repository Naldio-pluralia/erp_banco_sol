# This migration comes from next_sgad (originally 20180107204810)
class CreateJoinTableMessagePosition < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_messages, :next_sgad_positions do |t|
      t.index [:next_sgad_message_id, :next_sgad_position_id], name: 'index_sgad_mees_poions_on_sgad_mege_id_and_sgad_poion_id'
      # t.index [:position_id, :message_id]
    end
  end
end
