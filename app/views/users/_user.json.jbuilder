json.extract! user, :id, :name, :photo, :bio, :postCounter, :created_at, :updated_at
json.url user_url(user, format: :json)
