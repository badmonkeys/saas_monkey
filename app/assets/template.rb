
run "rm app/assets/stylesheets/application.css"
copy_file 'app/assets/stylesheets/application.scss'
copy_file 'app/assets/javascripts/application.coffee'
run 'rm app/assets/javascripts/application.js'

create_file 'app/assets/javascripts/channels/channel.js', ''
