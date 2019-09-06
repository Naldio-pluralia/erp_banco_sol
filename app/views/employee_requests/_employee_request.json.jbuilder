json.extract! employee_request, :id, :employee_id, :name, :note, :request_type_id, :created_at, :updated_at
json.url employee_request_url(employee_request, format: :json)
