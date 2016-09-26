
run "rm app/assets/stylesheets/application.css"
copy_file 'app/assets/stylesheets/application.scss'
copy_file 'app/assets/javascripts/application.coffee', force: true
