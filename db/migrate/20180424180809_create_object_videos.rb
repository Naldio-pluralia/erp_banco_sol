class CreateObjectVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :object_videos do |t|
      t.string :local_title
      t.string :local_file
      t.string :local_file_tmp
      t.boolean :local_file_processing
      t.string :local_watermark_image
      t.string :youtube_video_id
      t.references :object, polymorphic: true
      t.integer :kind

      t.timestamps
    end
  end
end
