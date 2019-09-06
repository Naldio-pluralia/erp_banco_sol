# This migration comes from next_sgad (originally 20180211181949)
class ChangeNoteFromResults < ActiveRecord::Migration[5.1]
  def change
    change_column :next_sgad_results, :note, :text
  end
end
