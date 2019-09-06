class AddLocalVideoToLessons < ActiveRecord::Migration[5.1]
  def change
    add_column :lessons, :local_video, :string
    add_column :lessons, :video_kind, :integer, null: false, default: 0
  end
end
