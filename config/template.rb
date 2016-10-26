template 'config/database.sample.yml.tt', force: true
copy_file 'config/puma.rb', force: true
copy_file 'config/sidekiq.yml'

insert_into_file 'config/application.rb', after: /require ['"]rails\/all['"].*\n/ do
  <<-APP.strip_heredoc
    require './lib/app_env'
  APP
end

apply('config/initializers/template.rb')
apply('config/environments/template.rb')

application 'config.active_job.queue_adapter = :sidekiq'
