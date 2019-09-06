json.extract! photo, :id, :image_url, :image_path, :created_at, :updated_at
json.url photo_url(photo, format: :json)
