# This migration comes from next_sgad (originally 20171115161157)
class MigrateFillJustificationColumns < ActiveRecord::Migration[5.1]
  def change
    Justification.all.each do |j|
      j.attendances.update_all(justification_status: j.status)
    end
  end
end
