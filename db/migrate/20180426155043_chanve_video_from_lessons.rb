class ChanveVideoFromLessons < ActiveRecord::Migration[5.1]
  def change
    change_column :lessons, :video, :string, null: true
  end
end
