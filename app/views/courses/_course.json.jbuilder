json.extract! course, :id, :name, :status, :for_all, :created_at, :updated_at
json.url course_url(course, format: :json)
