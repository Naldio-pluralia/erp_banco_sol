json.extract! employee_answer, :id, :question_id, :answer, :option, :employee_course_id, :created_at, :updated_at
json.url employee_answer_url(employee_answer, format: :json)
