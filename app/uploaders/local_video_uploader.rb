class LocalVideoUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

 # Use carrierwave-video gem's methods here

 include ::CarrierWave::Video

 # Use carrierwave-video-thumbnailer gem's methods here

 include ::CarrierWave::Video::Thumbnailer

 PROCESSED_DEFAULTS = {

  resolution:           '500x400', # desired video resolution; by default it preserves height ratio preserve_aspect_ratio: :height.

  video_codec:          'libx264', # H.264/MPEG-4 AVC video codec

  constant_rate_factor: '30', # GOP Size

  frame_rate:           '25', # frame rate

  audio_codec:          'aac', # AAC audio codec

  audio_bitrate:        '64k', # Audio bitrate

  audio_sample_rate:    '44100' # Audio sampling frequency

}.freeze

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  version :thumb do
    process thumbnail: [
      { format: 'png', quality: 10, size: 200, seek: '50%', logger: Rails.logger }
    ]
    def full_filename(for_file)
      png_name for_file, version_name
    end
    process :apply_png_content_type
  end
 
 
 
  def png_name(for_file, version_name)
    %(#{version_name}_#{for_file.chomp(File.extname(for_file))}.png)
  end
 
  def apply_png_content_type(*)
    file.instance_variable_set(:@content_type, 'image/png')
  end

  def size_range
    0..500.megabytes
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w[mov mp4 3gp mkv webm m4v avi]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
