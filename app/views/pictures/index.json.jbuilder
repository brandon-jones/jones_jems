json.array!(@pictures) do |picture|
  json.extract! picture, :id, :description, :my_work_id, :image
  json.url picture_url(picture, format: :json)
end
