# This migration comes from next_sgad (originally 20171111094154)
class CreateJoinTableAttendanceJustification < ActiveRecord::Migration[5.1]
  def change
    create_join_table :next_sgad_attendances, :next_sgad_justifications do |t|
      t.index [:next_sgad_attendance_id, :next_sgad_justification_id], name: 'indx_nxt_sgd_tndncs_jstns_on_attendence_id_and_justification_id'
      # t.index [:next_sgad_justification_id, :next_sgad_attendance_id]
    end
  end
end
