json.array!(@notification_templates) do |notification_template|
  json.extract! notification_template, :id, :name, :body, :from, :to
  json.url notification_template_url(notification_template, format: :json)
end
