json.extract! employee_absence, :id, :employee_id, :absence_type_id, :returned_at, :left_at, :absent_days_number, :created_at, :updated_at
json.url employee_absence_url(employee_absence, format: :json)
