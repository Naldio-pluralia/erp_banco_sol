# This migration comes from next_sgad (originally 20180107204831)
class CreateJoinTableMessageEmployee < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_messages, :next_sgad_employees do |t|
      t.index [:next_sgad_message_id, :next_sgad_employee_id], name: 'index_sgad_eoyees_messages_on_sgad_mage_id_and_sgad_eoyee_id'
      # t.index [:employee_id, :message_id]
    end
  end
end
