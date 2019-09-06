json.extract! object_attachment, :id, :file, :description, :extension_whitelist, :object_id, :object_type, :created_at, :updated_at
json.url object_attachment_url(object_attachment, format: :json)
