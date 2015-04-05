json.array!(@my_works) do |my_work|
  json.extract! my_work, :id, :title, :tags, :description, :cover
  json.url my_work_url(my_work, format: :json)
end
