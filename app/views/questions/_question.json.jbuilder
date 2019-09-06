json.extract! question, :id, :exam_id, :number, :description, :type, :value, :boolean_option, :created_at, :updated_at
json.url question_url(question, format: :json)
