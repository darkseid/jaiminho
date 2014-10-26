node[:deploy].each do |application, deploy|  
  if application == 'api' # replace api with your app
    run "bundle exec rake sidekiq:start"
  end
end