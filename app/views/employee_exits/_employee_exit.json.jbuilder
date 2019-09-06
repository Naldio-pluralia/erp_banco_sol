json.extract! employee_exit, :id, :employee_id, :absence_type_id, :kind, :date, :left_at, :returned_at, :number_of_hours_absent, :created_at, :updated_at
json.url employee_exit_url(employee_exit, format: :json)
