class ObjectVideoSerializer < ActiveModel::Serializer
  attributes :id, :local_title, :local_file, :local_file_tmp, :local_file_processing, :local_watermark_image, :youtube_video_id, :kind
  has_one :object
end
