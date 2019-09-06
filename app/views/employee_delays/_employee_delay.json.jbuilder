json.extract! employee_delay, :id, :employee_id, :absence_type_id, :date, :arrived_at, :number_of_hours_late, :created_at, :updated_at
json.url employee_delay_url(employee_delay, format: :json)
