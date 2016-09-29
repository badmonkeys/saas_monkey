
run "rm app/assets/stylesheets/application.css"
copy_file 'app/assets/stylesheets/application.scss'

apply('app/assets/javascripts/template.rb')
