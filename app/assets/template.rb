
run "rm app/assets/stylesheets/application.css"
copy_file 'app/assets/stylesheets/application.scss'
copy_file 'app/assets/stylesheets/_footer.scss'
copy_file 'app/assets/stylesheets/_navigation.scss'

apply('app/assets/javascripts/template.rb')

after_bundle do
  inside './app/assets/stylesheets' do
    run 'bundle exec bitters install'
  end
end
