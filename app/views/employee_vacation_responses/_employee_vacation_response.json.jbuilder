json.extract! employee_vacation_response, :id, :employee_vacation_id, :employee_id, :status, :kind, :created_at, :updated_at
json.url employee_vacation_response_url(employee_vacation_response, format: :json)
