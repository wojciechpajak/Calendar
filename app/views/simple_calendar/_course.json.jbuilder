json.extract! course, :id, :title, :location, :lecturer, :start_time, :end_time, :lecturer_index, :created_at, :updated_at
json.url course_url(course, format: :json)
