json.extract! object_activity, :id, :description, :object_id, :object_type, :creator_id, :creator_type, :created_at, :updated_at
json.url object_activity_url(object_activity, format: :json)
