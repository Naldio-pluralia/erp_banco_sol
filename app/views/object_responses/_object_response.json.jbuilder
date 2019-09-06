json.extract! object_response, :id, :employee_id, :object_id, :object_type, :status, :kind, :created_at, :updated_at
json.url object_response_url(object_response, format: :json)
