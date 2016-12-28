json.array!(@users) do |user|
  json.name       	user.name
  json.id			user.id
  json.trips        user.trips.length
  json.user_since 	user.created_at.strftime('%B %Y')
  json.image_url    user.image.url(:medium)
end