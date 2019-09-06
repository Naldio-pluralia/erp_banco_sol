json.extract! employee_question, :id, :employee_course_id, :employee_exam_id, :question_id, :status, :created_at, :updated_at
json.url employee_question_url(employee_question, format: :json)
