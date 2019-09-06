json.extract! vacancy, :id, :position, :requirements, :number, :status, :target, :created_at, :updated_at
json.url vacancy_url(vacancy, format: :json)
