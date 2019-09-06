class ChangeVideoKind < ActiveRecord::Migration[5.1]
  def change
    Lesson.update_all(video_kind: 1)
  end
end
