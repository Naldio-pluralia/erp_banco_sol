json.extract! employee_vacation, :id, :employee_id, :left_at, :returned_at, :number_of_days, :created_at, :updated_at
json.url employee_vacation_url(employee_vacation, format: :json)
