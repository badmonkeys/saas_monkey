run 'rm app/assets/javascripts/application.js'
copy_file 'app/assets/javascripts/application.coffee'
copy_file 'app/assets/javascripts/application/navigation.coffee'

create_file 'app/assets/javascripts/channels/channel.js', ''

