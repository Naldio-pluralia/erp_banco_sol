json.extract! object_video, :id, :local_title, :local_file, :local_file_tmp, :local_file_processing, :local_watermark_image, :youtube_video_id, :object_id, :object_type, :kind, :created_at, :updated_at
json.url object_video_url(object_video, format: :json)
