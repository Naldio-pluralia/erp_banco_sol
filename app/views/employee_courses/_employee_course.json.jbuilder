json.extract! employee_course, :id, :employee_id, :course_id, :end, :status, :attempt_number, :created_at, :updated_at
json.url employee_course_url(employee_course, format: :json)
