# This migration comes from next_sgad (originally 20180103084324)
class CreateJoinTableMessageFunction < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_messages, :next_sgad_functions do |t|
      t.index [:next_sgad_message_id, :next_sgad_function_id], name: 'idx_sgad_funions_mesges_on_sgad_mesge_id_and_sgad_funion_id'
    end
  end
end
