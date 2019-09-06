json.extract! lesson, :id, :name, :video, :text, :chapter_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
